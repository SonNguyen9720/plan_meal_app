part of 'individual_bloc.dart';

abstract class IndividualEvent extends Equatable {
  const IndividualEvent();
}

class IndividualLoadingDataEvent extends IndividualEvent {
  final DateTime dateStart;
  final DateTime dateEnd;

  const IndividualLoadingDataEvent(
      {required this.dateStart, required this.dateEnd});

  @override
  List<Object?> get props => [dateStart, dateEnd];
}

class IndividualChangeDateEvent extends IndividualEvent {
  final DateTime dateStart;
  final DateTime dateEnd;

  const IndividualChangeDateEvent(
      {required this.dateStart, required this.dateEnd});

  @override
  List<Object?> get props => [dateStart, dateEnd];
}

class IndividualRemoveIngredientEvent extends IndividualEvent {
  final DateTime dateStart;
  final DateTime dateEnd;
  final Ingredients ingredient;
  final List<IngredientByDay> listIngredient;
  final int indexIngredientByDay;
  final int indexIngredientCategories;
  final int indexIngredients;

  const IndividualRemoveIngredientEvent({
    required this.dateStart,
    required this.dateEnd,
    required this.ingredient,
    this.listIngredient = const [],
    required this.indexIngredientByDay,
    required this.indexIngredientCategories,
    required this.indexIngredients,
  });

  @override
  List<Object?> get props => [
        dateStart,
        dateEnd,
        ingredient,
        listIngredient,
        indexIngredientByDay,
        indexIngredientCategories,
        indexIngredients
      ];
}

class IndividualUpdateIngredientEvent extends IndividualEvent {
  final DateTime dateStart;
  final DateTime dateEnd;
  final Ingredients ingredient;
  final List<IngredientByDay> listIngredient;
  final int indexIngredientByDay;
  final int indexIngredientCategories;
  final int indexIngredients;
  final bool value;

  const IndividualUpdateIngredientEvent({
    required this.dateStart,
    required this.dateEnd,
    required this.listIngredient,
    required this.indexIngredientByDay,
    required this.indexIngredientCategories,
    required this.indexIngredients,
    required this.ingredient,
    required this.value,
  });

  @override
  List<Object?> get props => [
        dateStart,
        dateEnd,
        listIngredient,
        indexIngredientByDay,
        indexIngredientCategories,
        indexIngredients,
        ingredient
      ];
}
