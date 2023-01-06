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
  final IngredientByDayEntity ingredient;
  final List<IngredientByDayEntity> listIngredient;

  const IndividualRemoveIngredientEvent(
      {required this.dateStart,
      required this.dateEnd,
      required this.ingredient,
      this.listIngredient = const []});

  @override
  List<Object?> get props => [dateStart, dateEnd, ingredient, listIngredient];
}

class IndividualUpdateIngredientEvent extends IndividualEvent {
  final DateTime dateStart;
  final DateTime dateEnd;
  final IngredientByDayEntity ingredient;
  final List<IngredientByDayEntity> listIngredient;
  final int index;
  final bool value;

  const IndividualUpdateIngredientEvent({
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
