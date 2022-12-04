import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/repositories/abstract/menu_repository.dart';
import 'package:plan_meal_app/domain/datetime_utils.dart';
import 'package:plan_meal_app/domain/entities/food_meal_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'plan_meal_event.dart';

part 'plan_meal_state.dart';

class PlanMealBloc extends Bloc<PlanMealEvent, PlanMealState> {
  final MenuRepository menuRepository;

  PlanMealBloc({required this.menuRepository})
      : super(PlanMealInitial(DateTime.now())) {
    on<PlanMealLoadData>(_onPlanMealLoadData);
    on<PlanMealRemoveDishEvent>(_onPlanMealRemoveDishEvent);
    on<PlanMealTrackDishEvent>(_onPlanMealTrackDishEvent);
    on<PlanMealChangeDateEvent>(_onPlanMealChangeDateEvent);
  }

  Future<void> _onPlanMealLoadData(
      PlanMealLoadData event, Emitter<PlanMealState> emit) async {
    emit(PlanMealLoadingState(dateTime: event.dateTime));
    var date = DateTimeUtils.parseDateTime(event.dateTime);
    var prefs = await SharedPreferences.getInstance();
    var groupId = prefs.getString("groupId") ?? "";
    var foodMealList = await menuRepository.getMealByDay(date);
    var foodGroupMealList = await menuRepository.getMealByGroupByDay(date, groupId);
    if (foodMealList.isEmpty && foodGroupMealList.isEmpty) {
      emit(PlanMealNoMeal(dateTime: event.dateTime));
    } else {
      List<FoodMealEntity> foodMealListEntity = [];
      for (var element in foodMealList) {
        FoodMealEntity entity = FoodMealEntity(
          foodToMenuId: element.dishToMenuId ?? 0,
          foodId: element.dishId ?? 0,
          meal: element.meal ?? "",
          calories: element.dish?.calories.toString() ?? "",
          name: element.dish?.name ?? "",
          image: element.dish?.imageUrl ?? "",
          tracked: element.tracked ?? false,
          type: element.type ?? "individual",
          quantity: element.quantity ?? 0,
          carb: element.dish!.carbohydrates ?? 0,
          protein: element.dish!.protein ?? 0,
          fat: element.dish!.fat ?? 0,
        );
        foodMealListEntity.add(entity);
      }
      for (var element in foodGroupMealList) {
        FoodMealEntity entity = FoodMealEntity(
          foodToMenuId: element.dishToMenuId ?? 0,
          foodId: element.dishId ?? 0,
          meal: element.meal ?? "",
          calories: element.dish?.calories.toString() ?? "",
          name: element.dish?.name ?? "",
          image: element.dish?.imageUrl ?? "",
          tracked: element.tracked ?? false,
          type: element.type ?? "group",
          quantity: element.quantity ?? 0,
          carb: element.dish!.carbohydrates ?? 0,
          protein: element.dish!.protein ?? 0,
          fat: element.dish!.fat ?? 0,
        );
        foodMealListEntity.add(entity);
      }
      emit(PlanMealHasMeal(
          foodMealEntity: foodMealListEntity, dateTime: event.dateTime));
    }
  }

  Future<void> _onPlanMealRemoveDishEvent(
      PlanMealRemoveDishEvent event, Emitter<PlanMealState> emit) async {
    var date = DateTimeUtils.parseDateTime(event.dateTime);
    emit(PlanMealWaiting(dateTime: event.dateTime));
    var listFood = List<FoodMealEntity>.from(event.foodMealEntity);
    var result =
        await menuRepository.removeFoodFromMenu(event.dishId, date, event.meal);
    emit(PlanMealFinished(dateTime: event.dateTime));
    if (result == "201") {
      listFood
          .removeWhere((element) => element.foodToMenuId == int.parse(event.dishId));
      if (listFood.isEmpty) {
        emit(PlanMealNoMeal(dateTime: event.dateTime));
      } else {
        emit(PlanMealHasMeal(
            foodMealEntity: listFood, dateTime: event.dateTime));
      }
    }
  }

  void _onPlanMealTrackDishEvent(
      PlanMealTrackDishEvent event, Emitter<PlanMealState> emit) async {
    // var date = DateTimeUtils.parseDateTime(event.dateTime);
    emit(PlanMealWaiting(dateTime: event.dateTime));
    var listFood = List<FoodMealEntity>.from(event.foodMealEntity);
    var result = await menuRepository.trackFood(event.dishToMenu);
    if (result == "201") {
      listFood[event.index] = FoodMealEntity(
        foodToMenuId: listFood[event.index].foodToMenuId,
        foodId: listFood[event.index].foodId,
        name: listFood[event.index].name,
        calories: listFood[event.index].calories,
        meal: listFood[event.index].meal,
        image: listFood[event.index].image,
        tracked: event.tracked,
        type: listFood[event.index].type,
        quantity: listFood[event.index].quantity, protein: listFood[event.index].protein,
        fat: listFood[event.index].fat,
        carb: listFood[event.index].carb,
      );
    }
    emit(PlanMealFinished(dateTime: event.dateTime));
    emit(PlanMealHasMeal(foodMealEntity: listFood, dateTime: event.dateTime));
  }

  Future<void> _onPlanMealChangeDateEvent(PlanMealChangeDateEvent event, Emitter<PlanMealState> emit) async {
    emit(PlanMealLoadingState(dateTime: event.dateTime));
    var date = DateTimeUtils.parseDateTime(event.dateTime);
    var foodMealList = await menuRepository.getMealByDay(date);
    if (foodMealList.isEmpty) {
      emit(PlanMealNoMeal(dateTime: event.dateTime));
    } else {
      List<FoodMealEntity> foodMealListEntity = [];
      for (var element in foodMealList) {
        FoodMealEntity entity = FoodMealEntity(
          foodToMenuId: element.dishToMenuId ?? 0,
          foodId: element.dishId ?? 0,
          meal: element.meal ?? "",
          calories: element.dish?.calories.toString() ?? "",
          name: element.dish?.name ?? "",
          image: element.dish?.imageUrl ?? "",
          tracked: element.tracked ?? false,
          type: element.type ?? "individual",
          quantity: element.quantity ?? 0,
          carb: element.dish!.carbohydrates ?? 0,
          protein: element.dish!.protein ?? 0,
          fat: element.dish!.fat ?? 0,
        );
        foodMealListEntity.add(entity);
      }
      emit(PlanMealHasMeal(
          foodMealEntity: foodMealListEntity, dateTime: event.dateTime));
    }
  }
}
