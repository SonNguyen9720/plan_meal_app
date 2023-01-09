part of 'groups_bloc.dart';

abstract class GroupsEvent extends Equatable {
  const GroupsEvent();
}

class GroupLoadingDataEvent extends GroupsEvent {
  final DateTime dateStart;
  final DateTime dateEnd;

  const GroupLoadingDataEvent({required this.dateStart, required this.dateEnd});

  @override
  List<Object?> get props => [dateStart, dateEnd];
}

class GroupLoadedDataEvent extends GroupsEvent {
  final List<dynamic> data;

  const GroupLoadedDataEvent(this.data);

  @override
  List<Object?> get props => [data];
}

class GroupChangeDateEvent extends GroupsEvent {
  final DateTime dateStart;
  final DateTime dateEnd;

  const GroupChangeDateEvent({required this.dateStart, required this.dateEnd});

  @override
  List<Object?> get props => [dateStart, dateEnd];
}

class GroupRemoveIngredientEvent extends GroupsEvent {
  final DateTime dateStart;
  final DateTime dateEnd;
  final Ingredients ingredient;
  final List<IngredientByDay> listIngredient;
  final int indexIngredientByDay;
  final int indexIngredientCategories;
  final int indexIngredients;

  const GroupRemoveIngredientEvent(
      {required this.dateStart,
      required this.dateEnd,
        required this.ingredient,
        this.listIngredient = const [],
        required this.indexIngredientByDay,
        required this.indexIngredientCategories,
        required this.indexIngredients,});

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

class GroupUpdateIngredientEvent extends GroupsEvent {
  final DateTime dateStart;
  final DateTime dateEnd;
  final Ingredients ingredient;
  final List<IngredientByDay> listIngredient;
  final int indexIngredientByDay;
  final int indexIngredientCategories;
  final int indexIngredients;
  final bool value;

  const GroupUpdateIngredientEvent({
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
  List<Object?> get props =>
      [
        dateStart,
        dateEnd,
        listIngredient,
        indexIngredientByDay,
        indexIngredientCategories,
        indexIngredients,
        ingredient
      ];
}
