part of 'add_food_bloc.dart';

abstract class AddFoodState extends Equatable {
  const AddFoodState();
}

class AddFoodInitial extends AddFoodState {
  @override
  List<Object> get props => [];
}
