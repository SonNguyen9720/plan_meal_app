import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/model/ingredient_by_day.dart';
import 'package:plan_meal_app/data/repositories/abstract/shopping_list_repository.dart';
import 'package:plan_meal_app/domain/datetime_utils.dart';
import 'package:plan_meal_app/domain/entities/ingredient_by_day_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> _onIndividualLoadingDataEvent(
      IndividualLoadingDataEvent event, Emitter<IndividualState> emit) async {
    emit(IndividualLoadingItem(dateTime: event.dateTime));
    String date = DateTimeUtils.parseDateTime(event.dateTime);
    var prefs = await SharedPreferences.getInstance();
    String groupId = prefs.getString("groupId") ?? "";
    List<IngredientByDay> listIngredient =
        await shoppingListRepository.getIngredient(date);
    List<IngredientByDay> listIngredientGroup =
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
    for (var ingredient in listIngredientGroup) {
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
          type: "group");
      listIngredientEntity.add(ingredientEntity);
    }
    if (listIngredientEntity.isEmpty) {
      emit(IndividualNoItem(dateTime: event.dateTime));
    } else {
      emit(IndividualHasItem(
          dateTime: event.dateTime, listIngredient: listIngredientEntity));
    }
  }

  Future<void> _onIndividualChangeDateEvent(
      IndividualChangeDateEvent event, Emitter<IndividualState> emit) async {
    emit(IndividualLoadingItem(dateTime: event.dateTime));
    String date = DateTimeUtils.parseDateTime(event.dateTime);
    var prefs = await SharedPreferences.getInstance();
    String groupId = prefs.getString("groupId") ?? "";
    List<IngredientByDay> listIngredient =
        await shoppingListRepository.getIngredient(date);
    List<IngredientByDay> listIngredientGroup =
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
          type: "individual");
      listIngredientEntity.add(ingredientEntity);
    }
    for (var ingredient in listIngredientGroup) {
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
          type: "group");
      listIngredientEntity.add(ingredientEntity);
    }
    if (listIngredientEntity.isEmpty) {
      emit(IndividualNoItem(dateTime: event.dateTime));
    } else {
      emit(IndividualHasItem(
          dateTime: event.dateTime, listIngredient: listIngredientEntity));
    }
  }

  Future<void> _onIndividualRemoveIngredientEvent(
      IndividualRemoveIngredientEvent event,
      Emitter<IndividualState> emit) async {
    String date = DateTimeUtils.parseDateTime(event.date);
    emit(IndividualWaiting());
    String ingredientId = event.ingredient.id;
    String statusCode =
        await shoppingListRepository.removeIngredient(ingredientId, date);
    emit(IndividualFinished());
    if (statusCode == "201") {
      List<IngredientByDayEntity> listIngredient = [];
      listIngredient.addAll(event.listIngredient);
      listIngredient.remove(event.ingredient);
      DateTime date = event.date;
      if (listIngredient.isEmpty) {
        emit(IndividualNoItem(dateTime: date));
      } else {
        emit(IndividualHasItem(dateTime: date, listIngredient: listIngredient));
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
    String id = event.ingredient.id;
    if (event.value) {
      statusCode = await shoppingListRepository.checkIngredient(id);
    } else {
      statusCode = await shoppingListRepository.uncheckIngredient(id);
    }
    var newIngredient = event.ingredient.updateChecked(checked: event.value);
    emit(IndividualFinished());
    if (statusCode == "201") {
      List<IngredientByDayEntity> listIngredient = [];
      listIngredient.addAll(event.listIngredient);
      listIngredient[event.index] = newIngredient;
      var date = event.date;
      emit(IndividualHasItem(dateTime: date, listIngredient: listIngredient));
    } else {
      throw "Error API";
    }
  }
}
