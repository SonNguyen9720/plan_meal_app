part of 'food_rating_bloc.dart';

abstract class FoodRatingState extends Equatable {
  const FoodRatingState();
}

class FoodRatingInitial extends FoodRatingState {
  @override
  List<Object> get props => [];
}
