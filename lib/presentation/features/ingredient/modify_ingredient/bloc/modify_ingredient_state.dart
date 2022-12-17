part of 'modify_ingredient_bloc.dart';

abstract class ModifyIngredientState extends Equatable {
  const ModifyIngredientState();
}

class ModifyIngredientLoading extends ModifyIngredientState {
  @override
  List<Object?> get props => [];
}

class ModifyIngredientInitial extends ModifyIngredientState {
  final List<MeasurementModel> measurement;
  final IngredientDetailEntity ingredientDetailEntity;

  const ModifyIngredientInitial(
      {required this.measurement, required this.ingredientDetailEntity});

  @override
  List<Object> get props => [measurement, ingredientDetailEntity];
}
