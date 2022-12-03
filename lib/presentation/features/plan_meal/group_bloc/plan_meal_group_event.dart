part of 'plan_meal_group_bloc.dart';

abstract class PlanMealGroupEvent extends Equatable {
  const PlanMealGroupEvent();

  @override
  List<Object> get props => [];
}

class PlanMealGroupLoadData extends PlanMealGroupEvent {
  final DateTime dateTime;

  const PlanMealGroupLoadData({required this.dateTime});
}

class PlanMealGroupRemoveDishEvent extends PlanMealGroupEvent {
  final String dishId;
  final DateTime dateTime;
  final String meal;
  final List<FoodMealEntity> foodMealEntity;

  const PlanMealGroupRemoveDishEvent(
      {required this.dishId,
        required this.dateTime,
        required this.meal,
        required this.foodMealEntity});
}

class PlanMealGroupTrackDishEvent extends PlanMealGroupEvent {
  final int index;
  final String dishToMenu;
  final DateTime dateTime;
  final String meal;
  final List<FoodMealEntity> foodMealEntity;
  final bool tracked;

  const PlanMealGroupTrackDishEvent(
      {required this.index,
        required this.dishToMenu,
        required this.dateTime,
        required this.meal,
        required this.foodMealEntity,
        required this.tracked});
}

class PlanMealGroupChangeDateEvent extends PlanMealGroupEvent {
  final DateTime dateTime;

  const PlanMealGroupChangeDateEvent({required this.dateTime});

  @override
  List<Object> get props => [dateTime];
}
