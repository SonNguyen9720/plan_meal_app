part of 'goal_weight_cubit.dart';

abstract class GoalWeightState extends Equatable {
  const GoalWeightState();
  @override
  List<Object> get props => [];
}

class GoalWeightInitial extends GoalWeightState {}

class GoalWeightStoraged extends GoalWeightState {
  final User user;

  const GoalWeightStoraged(this.user);

  @override
  List<Object> get props => [user];
}

class GoalWeightFinished extends GoalWeightState {}
