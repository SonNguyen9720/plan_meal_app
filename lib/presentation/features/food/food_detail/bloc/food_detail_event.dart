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
  @override
  List<Object?> get props => [];
}

class FoodDetailDislikeEvent extends FoodDetailEvent {
  @override
  List<Object?> get props => [];
}

class FoodDetailScreenDeselectEvent extends FoodDetailEvent {
  @override
  List<Object?> get props => [];
}
