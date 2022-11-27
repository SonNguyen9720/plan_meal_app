part of 'ingredient_bloc.dart';

abstract class IngredientEvent extends Equatable {
  const IngredientEvent();

  @override
  List<Object> get props => [];
}

class IngredientAddIngredientEvent extends IngredientEvent {
  final List<IngredientDetailEntity> ingredientDetailEntityList;
  final IngredientDetailEntity ingredientDetailEntity;
  final DateTime date;

  const IngredientAddIngredientEvent(
      {required this.ingredientDetailEntityList,
      required this.ingredientDetailEntity,
      required this.date});
}

class IngredientSendIngredientEvent extends IngredientEvent {
  final List<IngredientDetailEntity> ingredientDetailEntityList;
  final DateTime date;

  const IngredientSendIngredientEvent(
      {required this.ingredientDetailEntityList,
        required this.date});
}