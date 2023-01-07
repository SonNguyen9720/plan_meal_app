part of 'food_detail_bloc.dart';

abstract class FoodDetailEvent extends Equatable {
  const FoodDetailEvent();
}

class FoodDetailLoadEvent extends FoodDetailEvent {
  final String foodId;

  const FoodDetailLoadEvent({required this.foodId});

  @override
  List<Object?> get props => [foodId];
}

class FoodDetailLikeEvent extends FoodDetailEvent {
  final String dishId;
  final FoodDetailEntity foodDetailEntity;

  const FoodDetailLikeEvent({required this.dishId ,required this.foodDetailEntity});

  @override
  List<Object?> get props => [dishId, foodDetailEntity];
}

class FoodDetailDislikeEvent extends FoodDetailEvent {
  final String dishId;
  final FoodDetailEntity foodDetailEntity;

  const FoodDetailDislikeEvent({required this.dishId, required this.foodDetailEntity});

  @override
  List<Object?> get props => [dishId, foodDetailEntity];
}

class FoodDetailDeselectEvent extends FoodDetailEvent {
  final String dishId;
  final FoodDetailEntity foodDetailEntity;
  final bool isLiked;

  const FoodDetailDeselectEvent({required this.dishId, required this.foodDetailEntity, required this.isLiked});

  @override
  List<Object?> get props => [dishId, foodDetailEntity, isLiked];
}
