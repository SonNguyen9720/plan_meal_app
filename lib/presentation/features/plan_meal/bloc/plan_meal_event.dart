part of 'plan_meal_bloc.dart';

abstract class PlanMealEvent extends Equatable {
  const PlanMealEvent();

  @override
  List<Object> get props => [];
}

class PlanMealLoadData extends PlanMealEvent {}
