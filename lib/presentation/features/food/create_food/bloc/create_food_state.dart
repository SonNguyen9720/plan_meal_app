part of 'create_food_bloc.dart';

abstract class CreateFoodState extends Equatable {
    const CreateFoodState();
}

class CreateFoodInitial extends CreateFoodState {
  @override
  List<Object> get props => [];
}

class CreateFoodLoading extends CreateFoodState {
  @override
  List<Object?> get props => [];
}

class CreateFoodFinished extends CreateFoodState {
  @override
  List<Object?> get props => [];
}