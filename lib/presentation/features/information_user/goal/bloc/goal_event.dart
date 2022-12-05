part of 'goal_bloc.dart';

abstract class GoalEvent extends Equatable {
  const GoalEvent();

  @override
  List<Object> get props => [];
}

class AddGoalEvent extends GoalEvent {
  final String goal;

  const AddGoalEvent(this.goal);
}

class RemoveGoalEvent extends GoalEvent {
  final String goal;

  const RemoveGoalEvent(this.goal);
}

class UpdateGoalEvent extends GoalEvent {
  final int index;

  const UpdateGoalEvent(this.index);
}

class SubmitListGoalEvent extends GoalEvent {
  final User user;
  final HealthGoal healthGoal;

  const SubmitListGoalEvent(this.user, this.healthGoal);
}
