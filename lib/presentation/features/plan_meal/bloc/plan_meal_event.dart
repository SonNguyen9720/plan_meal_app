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

class PlanMealLoadDishGroup extends PlanMealEvent {
  final DateTime dateTime;
  final List<FoodMealEntity> foodList;

  const PlanMealLoadDishGroup({required this.dateTime, this.foodList = const []});
}

class PlanMealLoadedDishGroup extends PlanMealEvent {
  final List<dynamic> data;
  final List<FoodMealEntity> foodList;

  const PlanMealLoadedDishGroup(this.data, {this.foodList = const []});
}

class PlanMealRemoveDishEvent extends PlanMealEvent {
  final FoodMealEntity dish;
  final DateTime dateTime;
  final String meal;
  final List<FoodMealEntity> individualEntityList;
  final List<FoodMealEntity> groupEntityList;
  final int member;

  const PlanMealRemoveDishEvent({
    required this.dish,
    required this.dateTime,
    required this.meal,
    required this.individualEntityList,
    required this.groupEntityList,
    required this.member,
  });
}

class PlanMealTrackDishEvent extends PlanMealEvent {
  final int index;
  final String dishToMenu;
  final DateTime dateTime;
  final String meal;
  final List<FoodMealEntity> individualEntityList;
  final List<FoodMealEntity> groupEntityList;
  final bool tracked;
  final int member;

  const PlanMealTrackDishEvent({
    required this.index,
    required this.dishToMenu,
    required this.dateTime,
    required this.meal,
    required this.individualEntityList,
    required this.groupEntityList,
    required this.tracked,
    required this.member,
  });
}

class PlanMealChangeDateEvent extends PlanMealEvent {
  final DateTime dateTime;

  const PlanMealChangeDateEvent({required this.dateTime});

  @override
  List<Object> get props => [dateTime];
}

class PlanMealSuggestFoodEvent extends PlanMealEvent {
  final DateTime dateTime;
  const PlanMealSuggestFoodEvent({required this.dateTime});

  @override
  List<Object> get props => [dateTime];
}
