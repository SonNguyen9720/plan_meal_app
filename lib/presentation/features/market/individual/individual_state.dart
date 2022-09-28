part of 'individual_bloc.dart';

abstract class IndividualState extends Equatable {
  const IndividualState();

  @override
  List<Object> get props => [];
}

class IndividualInitial extends IndividualState {}

class IndividualLoadingItem extends IndividualState {}

class IndividualNoItem extends IndividualState {}

class IndividualHasItem extends IndividualState {}
