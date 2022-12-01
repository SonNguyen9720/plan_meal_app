import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/model/ingredient_by_day.dart';
import 'package:plan_meal_app/data/repositories/abstract/shopping_list_repository.dart';
import 'package:plan_meal_app/domain/datetime_utils.dart';
import 'package:plan_meal_app/domain/entities/ingredient_by_day_entity.dart';

part 'groups_event.dart';

part 'groups_state.dart';

class GroupsBloc extends Bloc<GroupsEvent, GroupsState> {
  final ShoppingListRepository shoppingListRepository;


  GroupsBloc({required this.shoppingListRepository}) : super(GroupsInitial()) {
    on<GroupLoadingDataEvent>(_onGroupLoadingDataEvent);
    on<GroupChangeDateEvent>(_onGroupChangeDateEvent);
    on<GroupRemoveIngredientEvent>(_onGroupRemoveIngredientEvent);
    on<GroupUpdateIngredientEvent>(_onGroupUpdateIngredientEvent);
  }

  Future<void> _onGroupLoadingDataEvent(
      GroupLoadingDataEvent event, Emitter<GroupsState> emit) async {
    emit(GroupLoadingItem(dateTime: event.dateTime));
    String date = DateTimeUtils.parseDateTime(event.dateTime);
    String groupId = "4"; //this is hard code
    List<IngredientByDay> listIngredient =
    await shoppingListRepository.getGroupIngredient(groupId, date);
    List<IngredientByDayEntity> listIngredientEntity = [];
    for (var ingredient in listIngredient) {
      var ingredientEntity = IngredientByDayEntity(
          ingredientIdToShoppingList:
          ingredient.ingredientToShoppingListId.toString(),
          id: ingredient.ingredientId.toString(),
          name: ingredient.ingredient?.name ?? "",
          imageUrl: ingredient.ingredient?.imageUrl ?? "",
          quantity: ingredient.quantity ?? 0,
          weight: ingredient.weight ?? 0,
          measurement: ingredient.measurementType?.toLowerCase() ?? "gramme",
          checked: ingredient.checked ?? false,
          type: "individual");
      listIngredientEntity.add(ingredientEntity);
    }
    if (listIngredientEntity.isEmpty) {
      emit(GroupNoItem(dateTime: event.dateTime));
    } else {
      emit(GroupHasItem(
          dateTime: event.dateTime, listIngredient: listIngredientEntity));
    }
  }

  Future<void> _onGroupChangeDateEvent(
      GroupChangeDateEvent event, Emitter<GroupsState> emit) async {
    emit(GroupLoadingItem(dateTime: event.dateTime));
    String date = DateTimeUtils.parseDateTime(event.dateTime);
    String groupId = "4";
    List<IngredientByDay> listIngredient =
    await shoppingListRepository.getGroupIngredient(groupId, date);
    List<IngredientByDayEntity> listIngredientEntity = [];
    for (var ingredient in listIngredient) {
      var ingredientEntity = IngredientByDayEntity(
          ingredientIdToShoppingList: ingredient.ingredientToShoppingListId.toString(),
          id: ingredient.ingredientId.toString(),
          name: ingredient.ingredient?.name ?? "",
          imageUrl: ingredient.ingredient?.imageUrl ?? "",
          quantity: ingredient.quantity ?? 0,
          weight: ingredient.weight ?? 0,
          measurement: ingredient.measurementType?.toLowerCase() ?? "gramme",
          checked: ingredient.checked ?? false,
          type: "group");
      listIngredientEntity.add(ingredientEntity);
    }
    if (listIngredientEntity.isEmpty) {
      emit(GroupNoItem(dateTime: event.dateTime));
    } else {
      emit(GroupHasItem(
          dateTime: event.dateTime, listIngredient: listIngredientEntity));
    }
  }

  Future<void> _onGroupRemoveIngredientEvent(
      GroupRemoveIngredientEvent event,
      Emitter<GroupsState> emit) async {
    String date = DateTimeUtils.parseDateTime(event.date);
    emit(GroupWaiting());
    String ingredientId = event.ingredient.id;
    String statusCode =
    await shoppingListRepository.removeIngredient(ingredientId, date);
    emit(GroupFinished());
    if (statusCode == "201") {
      List<IngredientByDayEntity> listIngredient = [];
      listIngredient.addAll(event.listIngredient);
      listIngredient.remove(event.ingredient);
      DateTime date = event.date;
      if (listIngredient.isEmpty) {
        emit(GroupNoItem(dateTime: date));
      } else {
        emit(GroupHasItem(dateTime: date, listIngredient: listIngredient));
      }
    } else {
      throw "Error api";
    }
  }

  Future<void> _onGroupUpdateIngredientEvent(
      GroupUpdateIngredientEvent event,
      Emitter<GroupsState> emit) async {
    emit(GroupWaiting());
    String statusCode = "";
    String id = event.ingredient.id;
    if (event.value) {
      statusCode = await shoppingListRepository.checkIngredient(id);
    } else {
      statusCode = await shoppingListRepository.uncheckIngredient(id);
    }
    var newIngredient = event.ingredient.updateChecked(checked: event.value);
    emit(GroupFinished());
    if (statusCode == "201") {
      List<IngredientByDayEntity> listIngredient = [];
      listIngredient.addAll(event.listIngredient);
      listIngredient[event.index] = newIngredient;
      var date = event.date;
      emit(GroupHasItem(dateTime: date, listIngredient: listIngredient));
    } else {
      throw "Error API";
    }
  }

}
