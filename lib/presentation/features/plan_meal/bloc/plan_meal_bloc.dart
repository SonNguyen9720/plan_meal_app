import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plan_meal_app/data/repositories/abstract/menu_repository.dart';
import 'package:plan_meal_app/domain/datetime_utils.dart';
import 'package:plan_meal_app/domain/entities/food_meal_entity.dart';

part 'plan_meal_event.dart';

part 'plan_meal_state.dart';

class PlanMealBloc extends Bloc<PlanMealEvent, PlanMealState> {
  final MenuRepository menuRepository;

  PlanMealBloc({required this.menuRepository})
      : super(PlanMealInitial(DateTime.now())) {
    on<PlanMealLoadData>(_onPlanMealLoadData);
    on<PlanMealRemoveDishEvent>(_onPlanMealRemoveDishEvent);
  }

  Future<void> _onPlanMealLoadData(
      PlanMealLoadData event, Emitter<PlanMealState> emit) async {
    emit(PlanMealLoadingState(dateTime: event.dateTime));
    var date = DateTimeUtils.parseDateTime(event.dateTime);
    var foodMealList = await menuRepository.getMealByDay(date);
    if (foodMealList.isEmpty) {
      emit(PlanMealNoMeal(dateTime: event.dateTime));
    } else {
      List<FoodMealEntity> foodMealListEntity = [];
      for (var element in foodMealList) {
        FoodMealEntity entity = FoodMealEntity(
            id: element.dishId ?? 0,
            meal: element.meal ?? "",
            calories: element.dish?.calories.toString() ?? "",
            name: element.dish?.name ?? "",
            image: element.dish?.imageUrl ?? "");
        foodMealListEntity.add(entity);
      }
      emit(PlanMealHasMeal(
          foodMealEntity: foodMealListEntity, dateTime: event.dateTime));
    }
  }

  Future<void> _onPlanMealRemoveDishEvent(
      PlanMealRemoveDishEvent event, Emitter<PlanMealState> emit) async {
    var date = DateTimeUtils.parseDateTime(event.dateTime);
    var listFood = List<FoodMealEntity>.from(event.foodMealEntity);
    var result =
        await menuRepository.removeFoodFromMenu(event.dishId, date, event.meal);
    if (result == "Created") {
      listFood.removeWhere((element) => element.id == int.parse(event.dishId));
      if (listFood.isEmpty) {
        emit(PlanMealNoMeal(dateTime: event.dateTime));
      } else {
        emit(PlanMealHasMeal(foodMealEntity: listFood, dateTime: event.dateTime));
      }
    }
  }
}
