part of 'add_food_bloc.dart';

abstract class AddFoodState extends Equatable {
  const AddFoodState();

  @override
  List<Object> get props => [];
}

class AddFoodInitial extends AddFoodState {}

class AddFoodLoading extends AddFoodState {}

class AddFoodNoFood extends AddFoodState {
  final DateTime date;
  final String meal;

  const AddFoodNoFood({required this.date, required this.meal});
}

class AddFoodHasFood extends AddFoodState {
  final DateTime date;
  final String meal;
  final List<FoodMealEntity> foodMealEntityList;

  const AddFoodHasFood(
      {required this.date,
      required this.meal,
      required this.foodMealEntityList});
}
