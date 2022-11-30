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
  final int? weight;
  final int? quantity;
  final String? measurement;
  final String? type;
  final IngredientDetailEntity ingredientDetailEntity;
  final List<String> measurementList;

  const UpdateIngredientUpdateDataEvent(
      {this.weight,
        this.quantity,
        this.measurement,
        this.type,
        required this.ingredientDetailEntity,
        this.measurementList = const []});

  @override
  List<Object?> get props => [weight, quantity, measurement, type];
}

class UpdateIngredientSendDataEvent extends UpdateIngredientEvent {
  final String ingredientId;
  final int? quantity;
  final int? weight;
  final String? measurement;
  final String? type;

  const UpdateIngredientSendDataEvent(
      {required this.ingredientId ,this.quantity, this.weight, this.measurement, this.type});

  @override
  List<Object?> get props => [quantity, weight, measurement, type];
}
