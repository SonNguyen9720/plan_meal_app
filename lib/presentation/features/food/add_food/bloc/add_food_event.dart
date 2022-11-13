part of 'add_food_bloc.dart';

abstract class AddFoodEvent extends Equatable {
  const AddFoodEvent();

  @override
  List<Object?> get props => [];
}

class AddFoodLoadFood extends AddFoodEvent {
  final String meal;
  final DateTime date;

  const AddFoodLoadFood({required this.meal, required this.date});
}

class AddFoodAddingFood extends AddFoodEvent {
  final List<FoodSearchEntity> foodSearchEntityList;
  final FoodSearchEntity foodAdd;
  final String meal;
  final DateTime date;

  const AddFoodAddingFood(
      {required this.foodSearchEntityList,
      required this.foodAdd,
      required this.meal,
      required this.date});
}
