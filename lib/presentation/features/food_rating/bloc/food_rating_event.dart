part of 'food_rating_bloc.dart';

abstract class FoodRatingEvent extends Equatable {
  const FoodRatingEvent();
}

class FoodRatingLoadFood extends FoodRatingEvent {
  @override
  List<Object?> get props => [];
}

class FoodRatingLikeFoodEvent extends FoodRatingEvent {
  final FoodRatingEntity foodRatingEntity;
  final int? favoriteIndex;
  final int? dislikedIndex;

  const FoodRatingLikeFoodEvent({required this.foodRatingEntity, this.favoriteIndex, this.dislikedIndex});

  @override
  List<Object?> get props => [foodRatingEntity, favoriteIndex, dislikedIndex];
}

class FoodRatingDislikedFoodEvent extends FoodRatingEvent {
  final FoodRatingEntity foodRatingEntity;
  final int? favoriteIndex;
  final int? dislikedIndex;

  const FoodRatingDislikedFoodEvent(
      {required this.foodRatingEntity, this.favoriteIndex, this.dislikedIndex});

  @override
  List<Object?> get props => [foodRatingEntity];
}
