part of 'plan_meal_bloc.dart';

abstract class PlanMealState extends Equatable {
  const PlanMealState();

  @override
  List<Object> get props => [];
}

class PlanMealInitial extends PlanMealState {}

class PlanMealLoadingState extends PlanMealState {}

class PlanMealNoMeal extends PlanMealState {}

class PlanMealHasMeal extends PlanMealState {
  final List<FoodMealEntity> foodMealEntity;

  const PlanMealHasMeal({required this.foodMealEntity});
}
