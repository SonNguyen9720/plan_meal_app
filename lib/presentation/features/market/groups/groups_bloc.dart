import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/config/socket_event.dart';
import 'package:plan_meal_app/data/local/measurement_list.dart';
import 'package:plan_meal_app/data/model/ingredient_by_day.dart';
import 'package:plan_meal_app/data/model/measurement_model.dart';
import 'package:plan_meal_app/data/network/AppSocket.dart';
import 'package:plan_meal_app/data/repositories/abstract/shopping_list_repository.dart';
import 'package:plan_meal_app/domain/datetime_utils.dart';
import 'package:plan_meal_app/domain/entities/ingredient_by_day_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../domain/entities/location_entity.dart';

part 'groups_event.dart';

part 'groups_state.dart';

class GroupsBloc extends Bloc<GroupsEvent, GroupsState> {
  final ShoppingListRepository shoppingListRepository;
  final AppSocket groupSocket = AppSocket();

  GroupsBloc({required this.shoppingListRepository}) : super(GroupsInitial(DateTime.now(), DateTime.now())) {
    groupSocket.initSocket();
    groupSocket.on(SocketEvent.getGroupShoppingList, (data) {
      add(GroupLoadedDataEvent(data['data']));
    });

    on<GroupLoadingDataEvent>(_onGroupLoadingDataEvent);
    on<GroupLoadedDataEvent>(onGroupLoadedDataEvent);
    on<GroupChangeDateEvent>(_onGroupChangeDateEvent);
    on<GroupRemoveIngredientEvent>(_onGroupRemoveIngredientEvent);
    on<GroupUpdateIngredientEvent>(_onGroupUpdateIngredientEvent);
  }

  Future<void> _onGroupLoadingDataEvent(GroupLoadingDataEvent event,
      Emitter<GroupsState> emit) async {
    emit(GroupLoadingItem(event.dateStart, event.dateEnd));
    var prefs = await SharedPreferences.getInstance();
    String dateStart = DateTimeUtils.parseDateTime(event.dateStart);
    String dateEnd = DateTimeUtils.parseDateTime(event.dateEnd);
    String groupId = prefs.getString("groupId") ?? "";
    if (groupId.isEmpty) {
      emit(GroupNoGroup(dateStart: event.dateStart, dateEnd: event.dateEnd));
      return;
    }
    Map<String, String> messageMap = {
      'fromDate': dateStart,
      'toDate': dateEnd,
      'groupId': groupId,
    };
    groupSocket.emit(SocketEvent.getGroupShoppingList, messageMap);
    // List<IngredientByDay> listIngredient = await shoppingListRepository
    //     .getGroupIngredient(groupId, dateStart, dateEnd);
    // List<IngredientByDayEntity> listIngredientEntity = [];
    // for (var locationCategory in listIngredient) {
    //   List<IngredientCategories> listCategory =
    //   locationCategory.ingredientCategories!;
    //   for (var category in listCategory) {
    //     List<Ingredients> ingredientList = category.ingredients!;
    //     for (var ingredient in ingredientList) {
    //       String id = ingredient.measurementType!.id.toString();
    //       MeasurementModel measurementModel =
    //       measurementList.firstWhere((element) => element.id == id);
    //       var ingredientEntity = IngredientByDayEntity(
    //         ingredientIdToShoppingList:
    //         ingredient.ingredientToShoppingListId.toString(),
    //         id: ingredient.ingredient!.id.toString(),
    //         name: ingredient.ingredient?.name ?? "",
    //         imageUrl: ingredient.ingredient?.imageUrl ?? "",
    //         quantity: ingredient.quantity ?? 0,
    //         measurement: measurementModel,
    //         checked: ingredient.checked ?? false,
    //         type: "group",
    //         location: LocationEntity(
    //             id: ingredient.location?.id.toString() ?? "",
    //             location: ingredient.location?.name ?? ""),
    //         note: ingredient.note ?? "",
    //       );
    //       listIngredientEntity.add(ingredientEntity);
    //     }
    //   }
    // }
    // if (listIngredientEntity.isEmpty) {
    //   emit(GroupNoItem(dateStart: event.dateStart, dateEnd: event.dateEnd));
    // } else {
    //   emit(GroupHasItem(
    //       dateStart: event.dateStart,
    //       dateEnd: event.dateEnd,
    //       listIngredient: listIngredient));
    // }
  }

  void onGroupLoadedDataEvent(GroupLoadedDataEvent event,
      Emitter<GroupsState> emit) {
    if (state is GroupNoItem || state is GroupHasItem ||
        state is GroupLoadingItem) {
      if (event.data.isEmpty) {
        emit(GroupNoItem(state.dateStart, state.dateEnd));
      } else {
        List<IngredientByDay> listIngredient = [];
        for (var element in event.data) {
          IngredientByDay ingredientByDay = IngredientByDay.fromJson(element);
          listIngredient.add(ingredientByDay);
        }
        emit(GroupHasItem(dateStart: state.dateStart,
            dateEnd: state.dateEnd,
            listIngredient: listIngredient));
      }
    }
  }

  Future<void> _onGroupChangeDateEvent(GroupChangeDateEvent event,
      Emitter<GroupsState> emit) async {
    emit(GroupLoadingItem(event.dateStart, event.dateEnd));
    String dateStart = DateTimeUtils.parseDateTime(event.dateStart);
    String dateEnd = DateTimeUtils.parseDateTime(event.dateEnd);

    var prefs = await SharedPreferences.getInstance();
    String groupId = prefs.getString("groupId") ?? "";
    if (groupId.isEmpty) {
      emit(GroupNoGroup(dateStart: event.dateStart, dateEnd: event.dateEnd));
      return;
    }
    List<IngredientByDay> listIngredient = await shoppingListRepository
        .getGroupIngredient(groupId, dateStart, dateEnd);
    List<IngredientByDayEntity> listIngredientEntity = [];
    for (var locationCategory in listIngredient) {
      List<IngredientCategories> listCategory =
      locationCategory.ingredientCategories!;
      for (var category in listCategory) {
        List<Ingredients> ingredientList = category.ingredients!;
        for (var ingredient in ingredientList) {
          String id = ingredient.measurementType!.id.toString();
          MeasurementModel measurementModel =
          measurementList.firstWhere((element) => element.id == id);
          var ingredientEntity = IngredientByDayEntity(
            ingredientIdToShoppingList:
            ingredient.ingredientToShoppingListId.toString(),
            id: ingredient.ingredient!.id.toString(),
            name: ingredient.ingredient?.name ?? "",
            imageUrl: ingredient.ingredient?.imageUrl ?? "",
            quantity: ingredient.quantity ?? 0,
            measurement: measurementModel,
            checked: ingredient.checked ?? false,
            type: "group",
            location: LocationEntity(
                id: ingredient.location?.id.toString() ?? "",
                location: ingredient.location?.name ?? ""),
            note: ingredient.note ?? "",
          );
          listIngredientEntity.add(ingredientEntity);
        }
      }
    }
    if (listIngredientEntity.isEmpty) {
      emit(GroupNoItem(event.dateStart, event.dateEnd));
    } else {
      emit(GroupHasItem(
          dateStart: event.dateStart,
          dateEnd: event.dateEnd,
          listIngredient: listIngredient));
    }
  }

  Future<void> _onGroupRemoveIngredientEvent(GroupRemoveIngredientEvent event,
      Emitter<GroupsState> emit) async {
    // String date = DateTimeUtils.parseDateTime(event.date);
    emit(GroupWaiting(dateStart: event.dateStart, dateEnd: event.dateEnd));
    String ingredientId = event.ingredient.ingredientToShoppingListId
        .toString();
    Map<String, dynamic> messageBody = {
      'ingredientToShoppingListId' : ingredientId,
    };
    groupSocket.emit(SocketEvent.removeIngredient, messageBody);
    // String statusCode =
    // await shoppingListRepository.removeIngredient(ingredientId);
    emit(GroupFinished(dateStart: event.dateStart, dateEnd: event.dateEnd));
    add(GroupLoadingDataEvent(dateStart: event.dateStart, dateEnd: event.dateEnd));
    // if (statusCode == "201") {
    //   List<IngredientByDay> listIngredient = [];
    //   listIngredient.addAll(event.listIngredient);
    //   listIngredient[event.indexIngredientByDay]
    //       .ingredientCategories![event.indexIngredientCategories]
    //       .ingredients!
    //       .remove(event.ingredient);
    //   if (listIngredient.isEmpty) {
    //     emit(GroupNoItem(event.dateStart, event.dateEnd));
    //   } else {
    //     emit(GroupHasItem(
    //         dateStart: event.dateStart,
    //         dateEnd: event.dateEnd,
    //         listIngredient: listIngredient));
    //   }
    // } else {
    //   throw "Error api";
    // }
  }

  Future<void> _onGroupUpdateIngredientEvent(GroupUpdateIngredientEvent event,
      Emitter<GroupsState> emit) async {
    emit(GroupWaiting(dateStart: event.dateStart, dateEnd: event.dateEnd));
    String statusCode = "";
    String id = event.ingredient.ingredientToShoppingListId.toString();
    if (event.value) {
      statusCode = await shoppingListRepository.checkIngredient(id);
    } else {
      statusCode = await shoppingListRepository.uncheckIngredient(id);
    }
    var newIngredient = Ingredients(
      ingredientToShoppingListId: event.ingredient.ingredientToShoppingListId,
      quantity: event.ingredient.quantity,
      checked: event.value,
      note: event.ingredient.note,
      createdAt: event.ingredient.createdAt,
      updatedAt: event.ingredient.updatedAt,
      ingredient: Ingredient(
          id: event.ingredient.ingredient!.id,
          name: event.ingredient.ingredient!.name,
          carbohydrates: event.ingredient.ingredient!.carbohydrates,
          fat: event.ingredient.ingredient!.fat,
          protein: event.ingredient.ingredient!.protein,
          calories: event.ingredient.ingredient!.calories,
          imageUrl: event.ingredient.ingredient!.imageUrl,
          suggestedPrice: event.ingredient.ingredient!.suggestedPrice,
          createdAt: event.ingredient.ingredient!.createdAt,
          updatedAt: event.ingredient.ingredient!.updatedAt,
          ingredientCategory: IngredientCategory(
            id: event.ingredient.ingredient!.ingredientCategory!.id,
            name: event.ingredient.ingredient!.ingredientCategory!.name,
            createdAt: event.ingredient.ingredient!.ingredientCategory!
                .createdAt,
            updatedAt: event.ingredient.ingredient!.ingredientCategory!
                .updatedAt,
          )
      ),
      measurementType: event.ingredient.measurementType,
      location: event.ingredient.location,
    );
    emit(GroupFinished(dateStart: event.dateStart, dateEnd: event.dateEnd));
    if (statusCode == "201") {
      List<IngredientByDay> listIngredient = [];
      listIngredient.addAll(event.listIngredient);
      listIngredient[event.indexIngredientByDay]
          .ingredientCategories![event.indexIngredientCategories]
          .ingredients![event.indexIngredients] = newIngredient;
      emit(GroupHasItem(
          dateStart: event.dateStart,
          dateEnd: event.dateEnd,
          listIngredient: listIngredient));
    } else {
      throw "Error API";
    }
  }
}
