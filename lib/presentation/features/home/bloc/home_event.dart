part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomeGetUserEvent extends HomeEvent {}

class HomeGetBMI extends HomeEvent {}

class HomeGetUserOverviewEvent extends HomeEvent {
  final DateTime dateTime;

  const HomeGetUserOverviewEvent({required this.dateTime});
}
