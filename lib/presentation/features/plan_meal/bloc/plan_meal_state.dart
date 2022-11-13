part of 'plan_meal_bloc.dart';

abstract class PlanMealState extends Equatable {
  final DateTime dateTime;
  const PlanMealState({required this.dateTime});

  @override
  List<Object> get props => [];
}

class PlanMealInitial extends PlanMealState {
  const PlanMealInitial(dateTime) : super(dateTime: dateTime);
}

class PlanMealLoadingState extends PlanMealState {
  const PlanMealLoadingState({required dateTime}) : super(dateTime: dateTime);
}

class PlanMealNoMeal extends PlanMealState {
  const PlanMealNoMeal({required dateTime}) : super(dateTime: dateTime);

  @override
  List<Object> get props => [dateTime];
}

class PlanMealHasMeal extends PlanMealState {
  final List<FoodMealEntity> foodMealEntity;

  const PlanMealHasMeal({required this.foodMealEntity, required dateTime}) : super(dateTime: dateTime);

  @override
  List<Object> get props => [foodMealEntity, dateTime];
}
