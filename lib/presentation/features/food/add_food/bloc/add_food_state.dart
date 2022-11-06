part of 'add_food_bloc.dart';

abstract class AddFoodState extends Equatable {
  const AddFoodState();
  @override
  List<Object> get props => [];
}

class AddFoodInitial extends AddFoodState {}

class AddFoodLoading extends AddFoodState {}

class AddFoodNoFood extends AddFoodState {}

class AddFoodHasFood extends AddFoodState {}
