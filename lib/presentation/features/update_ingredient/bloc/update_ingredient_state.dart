part of 'update_ingredient_bloc.dart';

abstract class UpdateIngredientState extends Equatable {
  const UpdateIngredientState();
}

class UpdateIngredientLoading extends UpdateIngredientState {
  @override
  List<Object> get props => [];
}

class UpdateIngredientInitial extends UpdateIngredientState {
  final List<String> measurement;
  final IngredientDetailEntity ingredientDetailEntity;

  const UpdateIngredientInitial(
      {required this.measurement, required this.ingredientDetailEntity});

  @override
  List<Object> get props => [measurement, ingredientDetailEntity];
}

class UpdateIngredientWaiting extends UpdateIngredientState {
  @override
  List<Object?> get props => [];
}

class UpdateIngredientFinished extends UpdateIngredientState {
  @override
  List<Object?> get props => [];
}
