part of 'individual_bloc.dart';

abstract class IndividualState extends Equatable {
  const IndividualState();

  @override
  List<Object> get props => [];
}

class IndividualInitial extends IndividualState {}

class IndividualFailed extends IndividualState {}

class IndividualLoadingItem extends IndividualState {
  final DateTime dateStart;
  final DateTime dateEnd;

  const IndividualLoadingItem({required this.dateStart, required this.dateEnd});
}

class IndividualNoItem extends IndividualState {
  final DateTime dateStart;
  final DateTime dateEnd;

  const IndividualNoItem({required this.dateStart, required this.dateEnd});
}

class IndividualHasItem extends IndividualState {
  final DateTime dateStart;
  final DateTime dateEnd;
  final List<IngredientByDay> listIngredient;

  const IndividualHasItem({required this.dateStart, required this.dateEnd, required this.listIngredient});
}

class IndividualWaiting extends IndividualState {}

class IndividualFinished extends IndividualState {}
