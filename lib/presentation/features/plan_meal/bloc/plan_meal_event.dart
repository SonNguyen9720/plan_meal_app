part of 'plan_meal_bloc.dart';

abstract class PlanMealEvent extends Equatable {
  const PlanMealEvent();

  @override
  List<Object> get props => [];
}

class PlanMealLoadData extends PlanMealEvent {
  final DateTime dateTime;

  const PlanMealLoadData({required this.dateTime});
}

class PlanMealRemoveDishEvent extends PlanMealEvent {
  final String dishId;
  final DateTime dateTime;
  final String meal;
  final List<FoodMealEntity> foodMealEntity;

  const PlanMealRemoveDishEvent(
      {required this.dishId,
      required this.dateTime,
      required this.meal,
      required this.foodMealEntity});
}

class PlanMealTrackDishEvent extends PlanMealEvent {
  final int index;
  final String dishToMenu;
  final DateTime dateTime;
  final String meal;
  final List<FoodMealEntity> foodMealEntity;
  final bool tracked;

  const PlanMealTrackDishEvent(
      {required this.index,
      required this.dishToMenu,
      required this.dateTime,
      required this.meal,
      required this.foodMealEntity,
      required this.tracked});
}
