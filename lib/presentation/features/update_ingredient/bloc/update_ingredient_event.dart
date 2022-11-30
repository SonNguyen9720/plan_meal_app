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
  final String? measurement;
  final String? type;
  final IngredientDetailEntity ingredientDetailEntity;
  final List<String> measurementList;

  const UpdateIngredientUpdateDataEvent(
      {this.quantity,
        this.measurement,
        this.type,
        required this.ingredientDetailEntity,
        this.measurementList = const []});

  @override
  List<Object?> get props => [quantity, measurement, type];
}
