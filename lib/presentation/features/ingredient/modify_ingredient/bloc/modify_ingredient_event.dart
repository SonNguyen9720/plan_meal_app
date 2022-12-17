part of 'modify_ingredient_bloc.dart';

abstract class ModifyIngredientEvent extends Equatable {
  const ModifyIngredientEvent();
}

class ModifyIngredientLoadDataEvent extends ModifyIngredientEvent {
  final IngredientDetailEntity ingredientDetailEntity;

  const ModifyIngredientLoadDataEvent({required this.ingredientDetailEntity});

  @override
  List<Object?> get props => [];
}

class ModifyIngredientUpdateDataEvent extends ModifyIngredientEvent {
  final int? quantity;
  final MeasurementModel? measurement;
  final String? type;
  final IngredientDetailEntity ingredientDetailEntity;

  const ModifyIngredientUpdateDataEvent({
    this.quantity,
    this.measurement,
    this.type,
    required this.ingredientDetailEntity,
  });

  @override
  List<Object?> get props => [quantity, measurement, type];
}
