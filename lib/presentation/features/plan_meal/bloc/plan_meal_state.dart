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
  final List<FoodMealEntity> foodList;
  final int member;

  const PlanMealLoadingState(
      {required dateTime, this.foodList = const [], this.member = 1})
      : super(dateTime: dateTime);

  @override
  List<Object> get props => [foodList, dateTime, member];
}

class PlanMealNoMeal extends PlanMealState {
  final int member;

  const PlanMealNoMeal({required dateTime, this.member = 1})
      : super(dateTime: dateTime);

  @override
  List<Object> get props => [dateTime];
}

class PlanMealHasMeal extends PlanMealState {
  final List<FoodMealEntity> foodMealIndividualEntity;
  final List<FoodMealEntity> foodMealGroupEntity;
  final int member;

  const PlanMealHasMeal(
      {required this.foodMealIndividualEntity,
      required this.foodMealGroupEntity,
      required dateTime,
      required this.member})
      : super(dateTime: dateTime);

  @override
  List<Object> get props =>
      [foodMealIndividualEntity, foodMealGroupEntity, dateTime, member];
}

class PlanMealWaiting extends PlanMealState {
  const PlanMealWaiting({required DateTime dateTime})
      : super(dateTime: dateTime);
}

class PlanMealFinished extends PlanMealState {
  const PlanMealFinished({required DateTime dateTime})
      : super(dateTime: dateTime);
}

class PlanMealError extends PlanMealState {
  final String errorMessage;

  const PlanMealError({required this.errorMessage, required DateTime dateTime})
      : super(dateTime: dateTime);
}
