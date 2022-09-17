part of 'goal_bloc.dart';

abstract class GoalState extends Equatable {
  const GoalState(this.goalList);

  final List<String> goalList;

  @override
  List<Object> get props => [goalList];
}

class GoalInitial extends GoalState {
  const GoalInitial(List<String> goalList) : super(goalList);
}

class GoalUpdated extends GoalState {
  const GoalUpdated(List<String> goalList) : super(goalList);
}

class GoalSubmit extends GoalState {
  final User user;
  const GoalSubmit(List<String> goalList, this.user) : super(goalList);
}
