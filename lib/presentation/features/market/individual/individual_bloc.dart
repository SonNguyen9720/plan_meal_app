import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/local/measurement_list.dart';
import 'package:plan_meal_app/data/model/ingredient_by_day.dart';
import 'package:plan_meal_app/data/model/measurement_model.dart';
import 'package:plan_meal_app/data/repositories/abstract/shopping_list_repository.dart';
import 'package:plan_meal_app/domain/datetime_utils.dart';
import 'package:plan_meal_app/domain/entities/ingredient_by_day_entity.dart';
import 'package:plan_meal_app/domain/entities/location_entity.dart';
// import 'package:shared_preferences/shared_preferences.dart';

part 'individual_event.dart';

part 'individual_state.dart';

class IndividualBloc extends Bloc<IndividualEvent, IndividualState> {
  final ShoppingListRepository shoppingListRepository;

  IndividualBloc({required this.shoppingListRepository})
      : super(IndividualInitial()) {
    on<IndividualLoadingDataEvent>(_onIndividualLoadingDataEvent);
    on<IndividualChangeDateEvent>(_onIndividualChangeDateEvent);
    on<IndividualRemoveIngredientEvent>(_onIndividualRemoveIngredientEvent);
    on<IndividualUpdateIngredientEvent>(_onIndividualUpdateIngredientEvent);
  }

  Future<void> _onIndividualLoadingDataEvent(IndividualLoadingDataEvent event,
      Emitter<IndividualState> emit) async {
    emit(IndividualLoadingItem(
        dateStart: event.dateStart, dateEnd: event.dateEnd));
    String dateStart = DateTimeUtils.parseDateTime(event.dateStart);
    String dateEnd = DateTimeUtils.parseDateTime(event.dateEnd);

    // var prefs = await SharedPreferences.getInstance();
    // String groupId = prefs.getString("groupId") ?? "";
    List<IngredientByDay> listIngredient =
    await shoppingListRepository.getIngredient(dateStart, dateEnd);
    List<IngredientByDayEntity> listIngredientEntity = [];
    for (var locationCategory in listIngredient) {
      // String locationId = locationCategory.id.toString();
      // String locationName = locationCategory.name!;
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
            type: "individual",
            location: LocationEntity(
                id: ingredient.location?.id.toString() ?? "",
                location: ingredient.location?.name ?? ""),
            note: ingredient.note ?? "",
          );
          listIngredientEntity.add(ingredientEntity);
        }
      }
    }
    //
    // for (var ingredient in listIngredient) {
    //   String id = ingredient
    //       .ingredientCategories.first.ingredients.first.measurementType.id!.id
    //       .toString();
    //   MeasurementModel measurementModel =
    //       measurementList.firstWhere((element) => element.id == id);
    //   var ingredientEntity = IngredientByDayEntity(
    //     ingredientIdToShoppingList:
    //         ingredient.ingredientToShoppingListId.toString(),
    //     id: ingredient.ingredient!.id.toString(),
    //     name: ingredient.ingredient?.name ?? "",
    //     imageUrl: ingredient.ingredient?.imageUrl ?? "",
    //     quantity: ingredient.quantity ?? 0,
    //     measurement: measurementModel,
    //     checked: ingredient.checked ?? false,
    //     type: "individual",
    //     location: LocationEntity(
    //         id: ingredient.location?.id.toString() ?? "",
    //         location: ingredient.location?.name ?? ""),
    //     note: ingredient.note ?? "",
    //   );
    //   listIngredientEntity.add(ingredientEntity);
    // }
    if (listIngredientEntity.isEmpty) {
      emit(
          IndividualNoItem(dateStart: event.dateStart, dateEnd: event.dateEnd));
    } else {
      emit(IndividualHasItem(
          dateStart: event.dateEnd,
          dateEnd: event.dateEnd,
          listIngredient: listIngredient));
    }
  }

  Future<void> _onIndividualChangeDateEvent(IndividualChangeDateEvent event,
      Emitter<IndividualState> emit) async {
    emit(IndividualLoadingItem(
        dateStart: event.dateStart, dateEnd: event.dateEnd));
    String dateStart = DateTimeUtils.parseDateTime(event.dateStart);
    String dateEnd = DateTimeUtils.parseDateTime(event.dateEnd);
    List<IngredientByDay> listIngredient =
    await shoppingListRepository.getIngredient(dateStart, dateEnd);
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
            type: "individual",
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
      emit(
          IndividualNoItem(dateStart: event.dateStart, dateEnd: event.dateEnd));
    } else {
      emit(IndividualHasItem(
          dateStart: event.dateStart,
          dateEnd: event.dateEnd,
          listIngredient: listIngredient));
    }
  }

  Future<void> _onIndividualRemoveIngredientEvent(
      IndividualRemoveIngredientEvent event,
      Emitter<IndividualState> emit) async {
    // String date = DateTimeUtils.parseDateTime(event.date);
    emit(IndividualWaiting());
    String ingredientId =
    event.ingredient.ingredientToShoppingListId.toString();
    String statusCode =
    await shoppingListRepository.removeIngredient(ingredientId);
    emit(IndividualFinished());
    if (statusCode == "201") {
      List<IngredientByDay> listIngredient = [];
      listIngredient.addAll(event.listIngredient);
      listIngredient[event.indexIngredientByDay]
          .ingredientCategories![event.indexIngredientCategories]
          .ingredients!
          .remove(event.ingredient);
      DateTime dateStart = event.dateStart;
      DateTime dateEnd = event.dateEnd;
      if (listIngredient.isEmpty) {
        emit(IndividualNoItem(dateStart: dateStart, dateEnd: dateEnd));
      } else {
        emit(IndividualHasItem(
            dateStart: dateStart,
            dateEnd: dateEnd,
            listIngredient: listIngredient));
      }
    } else {
      throw "Error api";
    }
  }

  Future<void> _onIndividualUpdateIngredientEvent(
      IndividualUpdateIngredientEvent event,
      Emitter<IndividualState> emit) async {
    emit(IndividualWaiting());
    String statusCode = "";
    String id = event.ingredient.ingredientToShoppingListId.toString();
    if (event.value) {
      statusCode = await shoppingListRepository.checkIngredient(id);
    } else {
      statusCode = await shoppingListRepository.uncheckIngredient(id);
    }
    event.value;
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
    emit(IndividualFinished());
    if (statusCode == "201") {
      List<IngredientByDay> listIngredient = [];
      listIngredient.addAll(event.listIngredient);
      listIngredient[event.indexIngredientByDay]
          .ingredientCategories![event.indexIngredientCategories]
          .ingredients![event.indexIngredients] = newIngredient;
      DateTime dateStart = event.dateStart;
      DateTime dateEnd = event.dateEnd;
      emit(IndividualHasItem(
          dateStart: dateStart,
          dateEnd: dateEnd,
          listIngredient: listIngredient));
    } else {
      throw "Error API";
    }
  }
}
