part of 'update_goal_bloc.dart';

abstract class UpdateGoalState extends Equatable {
  const UpdateGoalState();
}

class UpdateGoalInitial extends UpdateGoalState {
  final String currentWeight;
  final String goalWeight;

  const UpdateGoalInitial(
      {required this.currentWeight, required this.goalWeight});

  @override
  List<Object> get props => [currentWeight, goalWeight];
}
