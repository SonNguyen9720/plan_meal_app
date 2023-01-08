part of 'food_exclusive_bloc.dart';

abstract class FoodExclusiveEvent extends Equatable {
  const FoodExclusiveEvent();
}

class FoodExclusiveGetIngredient extends FoodExclusiveEvent {
  @override
  List<Object?> get props => [];
}

class FoodExclusiveDeleteIngredient extends FoodExclusiveEvent {
  final FoodExclusiveEntity ingredient;
  final int index;

  const FoodExclusiveDeleteIngredient({required this.ingredient, required this.index});

  @override
  List<Object?> get props => [ingredient];

}
