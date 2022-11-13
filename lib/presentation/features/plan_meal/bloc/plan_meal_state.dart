part of 'plan_meal_bloc.dart';

abstract class PlanMealState extends Equatable {
  const PlanMealState();

  @override
  List<Object> get props => [];
}

class PlanMealInitial extends PlanMealState {}

class PlanMealLoadingState extends PlanMealState {}

class PlanMealNoMeal extends PlanMealState {
  final DateTime dateTime;

  const PlanMealNoMeal({required this.dateTime});

  @override
  List<Object> get props => [dateTime];
}

class PlanMealHasMeal extends PlanMealState {
  final List<FoodMealEntity> foodMealEntity;
  final DateTime dateTime;

  const PlanMealHasMeal({required this.foodMealEntity, required this.dateTime});

  @override
  List<Object> get props => [foodMealEntity, dateTime];
}
