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
      {required this.ingredientDetailEntityList, required this.date});
}

class IngredientRemoveIngredientEvent extends IngredientEvent {
  final List<IngredientDetailEntity> ingredientDetailEntityList;
  final IngredientDetailEntity ingredientDetailEntity;
  final DateTime date;

  const IngredientRemoveIngredientEvent(
      {required this.ingredientDetailEntityList,
      required this.ingredientDetailEntity,
      required this.date});
}

class IngredientUpdateIngredientEvent extends IngredientEvent {
  final List<IngredientDetailEntity> ingredientDetailEntityList;
  final IngredientDetailEntity ingredientDetailEntity;
  final DateTime date;
  final int index;

  const IngredientUpdateIngredientEvent({
    required this.ingredientDetailEntity,
    required this.ingredientDetailEntityList,
    required this.date,
    required this.index
  });
}
