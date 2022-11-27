part of 'individual_bloc.dart';

abstract class IndividualState extends Equatable {
  const IndividualState();

  @override
  List<Object> get props => [];
}

class IndividualInitial extends IndividualState {}

class IndividualFailed extends IndividualState {}

class IndividualLoadingItem extends IndividualState {
  final DateTime dateTime;

  const IndividualLoadingItem({required this.dateTime});
}

class IndividualNoItem extends IndividualState {
  final DateTime dateTime;

  const IndividualNoItem({required this.dateTime});
}

class IndividualHasItem extends IndividualState {
  final DateTime dateTime;
  final List<IngredientByDayEntity> listIngredient;

  const IndividualHasItem({required this.dateTime, required this.listIngredient});
}
