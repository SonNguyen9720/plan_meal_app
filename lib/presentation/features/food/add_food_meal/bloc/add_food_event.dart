part of 'add_food_bloc.dart';

abstract class AddFoodEvent extends Equatable {
  const AddFoodEvent();

  @override
  List<Object?> get props => [];
}

class AddFoodLoadFood extends AddFoodEvent {
  final String mealId;
  final DateTime date;
  final List<FoodSearchEntity> foodSearchEntityList;

  const AddFoodLoadFood({required this.mealId, required this.date, required this.foodSearchEntityList});
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

class AddFoodRemovingFood extends AddFoodEvent {
  final List<FoodSearchEntity> foodSearchEntityList;
  final FoodSearchEntity foodRemove;
  final String meal;
  final DateTime date;

  const AddFoodRemovingFood(
      {required this.foodSearchEntityList,
      required this.foodRemove,
      required this.meal,
      required this.date});
}

class AddFoodSendFood extends AddFoodEvent {
  final List<FoodSearchEntity> foodSearchEntityList;
  final String meal;
  final DateTime date;

  const AddFoodSendFood(
      {required this.foodSearchEntityList,
      required this.meal,
      required this.date});
}

class AddFoodUpdateFood extends AddFoodEvent {
  final List<FoodSearchEntity> foodSearchEntityList;
  final String meal;
  final DateTime date;
  final int quantity;
  final String type;
  final int index;

  const AddFoodUpdateFood(
      {required this.foodSearchEntityList,
      required this.date,
      required this.meal,
      required this.quantity,
      required this.type,
      required this.index});
}
