part of 'food_rating_bloc.dart';

abstract class FoodRatingState extends Equatable {
  const FoodRatingState();
}

class FoodRatingInitial extends FoodRatingState {
  @override
  List<Object> get props => [];
}

class FoodRatingLoading extends FoodRatingState {
  @override
  List<Object?> get props => [];
}

class FoodRatingLoaded extends FoodRatingState {
  final List<FoodRatingEntity> favoriteFoodList;
  final List<FoodRatingEntity> dislikedFoodList;

  const FoodRatingLoaded(
      {required this.favoriteFoodList, required this.dislikedFoodList});

  @override
  List<Object?> get props => [favoriteFoodList, dislikedFoodList];
}
