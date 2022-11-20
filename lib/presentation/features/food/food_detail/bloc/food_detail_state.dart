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


  @override
  List<Object?> get props => throw UnimplementedError();

}


