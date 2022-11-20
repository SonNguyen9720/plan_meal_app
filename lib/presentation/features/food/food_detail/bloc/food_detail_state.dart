part of 'food_detail_bloc.dart';

abstract class FoodDetailState extends Equatable {
  const FoodDetailState();
}

class FoodDetailInitial extends FoodDetailState {
  @override
  List<Object> get props => [];
}

class FoodDetailLoading extends FoodDetailState {
  @override
  List<Object?> get props => [];
}

class FoodDetailLoaded extends FoodDetailState {
  final FoodDetailEntity foodDetailEntity;

  const FoodDetailLoaded({required this.foodDetailEntity});

  @override
  List<Object?> get props => [foodDetailEntity];

}


