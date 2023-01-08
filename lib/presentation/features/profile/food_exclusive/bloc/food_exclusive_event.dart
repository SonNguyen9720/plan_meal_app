part of 'food_exclusive_bloc.dart';

abstract class FoodExclusiveEvent extends Equatable {
  const FoodExclusiveEvent();
}

class FoodExclusiveGetIngredient extends FoodExclusiveEvent {
  @override
  List<Object?> get props => [];
}
