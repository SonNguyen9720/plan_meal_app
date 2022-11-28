part of 'individual_bloc.dart';

abstract class IndividualEvent extends Equatable {
  const IndividualEvent();
}

class IndividualLoadingDataEvent extends IndividualEvent {
  final DateTime dateTime;

  const IndividualLoadingDataEvent({required this.dateTime});

  @override
  List<Object?> get props => [];
}

class IndividualChangeDateEvent extends IndividualEvent {
  final DateTime dateTime;

  const IndividualChangeDateEvent({required this.dateTime});

  @override
  List<Object?> get props => [dateTime];
}

class IndividualRemoveIngredientEvent extends IndividualEvent {
  final DateTime date;
  final IngredientByDayEntity ingredient;
  final List<IngredientByDayEntity> listIngredient;

  const IndividualRemoveIngredientEvent({required this.date, required this.ingredient, this.listIngredient = const []});

  @override
  List<Object?> get props => [date, ingredient, listIngredient];
}
