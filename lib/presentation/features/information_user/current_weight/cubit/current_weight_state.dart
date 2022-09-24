part of 'current_weight_cubit.dart';

abstract class CurrentWeightState extends Equatable {
  const CurrentWeightState();

  @override
  List<Object> get props => [];
}

class CurrentWeightInitial extends CurrentWeightState {}

class CurrentWeightStoraged extends CurrentWeightState {
  final User user;

  const CurrentWeightStoraged({required this.user});

  @override
  List<Object> get props => [user];
}

class CurrentWeightFinished extends CurrentWeightState {}
