part of 'groups_bloc.dart';

abstract class GroupsEvent extends Equatable {
  const GroupsEvent();
}

class GroupLoadingDataEvent extends GroupsEvent {
  final DateTime dateTime;

  const GroupLoadingDataEvent({required this.dateTime});

  @override
  List<Object?> get props => [];
}

class GroupChangeDateEvent extends GroupsEvent {
  final DateTime dateTime;

  const GroupChangeDateEvent({required this.dateTime});

  @override
  List<Object?> get props => [dateTime];
}

class GroupRemoveIngredientEvent extends GroupsEvent {
  final DateTime date;
  final IngredientByDayEntity ingredient;
  final List<IngredientByDayEntity> listIngredient;

  const GroupRemoveIngredientEvent(
      {required this.date,
        required this.ingredient,
        this.listIngredient = const []});

  @override
  List<Object?> get props => [date, ingredient, listIngredient];
}

class GroupUpdateIngredientEvent extends GroupsEvent {
  final DateTime date;
  final IngredientByDayEntity ingredient;
  final List<IngredientByDayEntity> listIngredient;
  final int index;
  final bool value;

  const GroupUpdateIngredientEvent({
    required this.date,
    required this.listIngredient,
    required this.index,
    required this.ingredient,
    required this.value,
  });

  @override
  List<Object?> get props => [date, listIngredient, index, ingredient];
}

