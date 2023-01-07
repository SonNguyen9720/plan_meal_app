part of 'groups_bloc.dart';

abstract class GroupsEvent extends Equatable {
  const GroupsEvent();
}

class GroupLoadingDataEvent extends GroupsEvent {
  final DateTime dateStart;
  final DateTime dateEnd;

  const GroupLoadingDataEvent({required this.dateStart, required this.dateEnd});

  @override
  List<Object?> get props => [];
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
  final IngredientByDayEntity ingredient;
  final List<IngredientByDayEntity> listIngredient;

  const GroupRemoveIngredientEvent(
      {required this.dateStart,
      required this.dateEnd,
      required this.ingredient,
      this.listIngredient = const []});

  @override
  List<Object?> get props => [dateStart, dateEnd, ingredient, listIngredient];
}

class GroupUpdateIngredientEvent extends GroupsEvent {
  final DateTime dateStart;
  final DateTime dateEnd;
  final IngredientByDayEntity ingredient;
  final List<IngredientByDayEntity> listIngredient;
  final int index;
  final bool value;

  const GroupUpdateIngredientEvent({
    required this.dateStart,
    required this.dateEnd,
    required this.listIngredient,
    required this.index,
    required this.ingredient,
    required this.value,
  });

  @override
  List<Object?> get props =>
      [dateStart, dateEnd, listIngredient, index, ingredient];
}
