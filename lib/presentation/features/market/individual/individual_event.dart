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
