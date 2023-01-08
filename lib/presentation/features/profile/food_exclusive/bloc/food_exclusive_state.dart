part of 'food_exclusive_bloc.dart';

abstract class FoodExclusiveState extends Equatable {
  const FoodExclusiveState();
}

class FoodExclusiveInitial extends FoodExclusiveState {
  @override
  List<Object> get props => [];
}

class FoodExclusiveLoadingState extends FoodExclusiveState {
  @override
  List<Object?> get props => [];
}
