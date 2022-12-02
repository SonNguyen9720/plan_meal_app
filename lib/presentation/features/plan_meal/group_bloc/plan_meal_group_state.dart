part of 'plan_meal_group_bloc.dart';

abstract class PlanMealGroupState extends Equatable {
  final DateTime dateTime;

  const PlanMealGroupState({required this.dateTime});

  @override
  List<Object> get props => [];
}

class PlanMealGroupInitial extends PlanMealGroupState {
  const PlanMealGroupInitial(dateTime) : super(dateTime: dateTime);
}

class PlanMealGroupLoadingState extends PlanMealGroupState {
  const PlanMealGroupLoadingState({required dateTime})
      : super(dateTime: dateTime);
}

class PlanMealGroupNoMeal extends PlanMealGroupState {
  const PlanMealGroupNoMeal({required dateTime}) : super(dateTime: dateTime);

  @override
  List<Object> get props => [dateTime];
}

class PlanMealGroupHasMeal extends PlanMealGroupState {
  final List<FoodMealEntity> foodMealEntity;

  const PlanMealGroupHasMeal({required this.foodMealEntity, required dateTime})
      : super(dateTime: dateTime);

  @override
  List<Object> get props => [foodMealEntity, dateTime];
}

class PlanMealGroupNoGroup extends PlanMealGroupState {
  const PlanMealGroupNoGroup({required DateTime dateTime})
      : super(dateTime: dateTime);
}
