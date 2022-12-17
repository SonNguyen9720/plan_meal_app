part of 'update_ingredient_bloc.dart';

abstract class UpdateIngredientEvent extends Equatable {
  const UpdateIngredientEvent();
}

class UpdateIngredientLoadDataEvent extends UpdateIngredientEvent {
  final IngredientDetailEntity ingredientDetailEntity;

  const UpdateIngredientLoadDataEvent({required this.ingredientDetailEntity});

  @override
  List<Object?> get props => [];
}

class UpdateIngredientUpdateDataEvent extends UpdateIngredientEvent {
  final int? quantity;
  final MeasurementModel? measurement;
  final String? type;
  final IngredientDetailEntity ingredientDetailEntity;
  final List<String> measurementList;

  const UpdateIngredientUpdateDataEvent(
      {
      this.quantity,
      this.measurement,
      this.type,
      required this.ingredientDetailEntity,
      required this.measurementList});

  @override
  List<Object?> get props => [quantity, measurement, type];
}

class UpdateIngredientSendDataEvent extends UpdateIngredientEvent {
  final String ingredientId;
  final int? quantity;
  final MeasurementModel? measurement;
  final String? type;

  const UpdateIngredientSendDataEvent(
      {required this.ingredientId,
      this.quantity,
      this.measurement,
      this.type});

  @override
  List<Object?> get props => [quantity, measurement, type];
}
