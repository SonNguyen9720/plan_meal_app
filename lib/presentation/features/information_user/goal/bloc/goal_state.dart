part of 'goal_bloc.dart';

abstract class GoalState extends Equatable {
  const GoalState();
  @override
  List<Object> get props => [];
}

class GoalInitial extends GoalState {
  final Map<HealthGoal, bool> healthGoalMap;
  final List<bool> render;

  const GoalInitial({this.healthGoalMap = const {
    HealthGoal.eat_healthier: false,
    HealthGoal.boost_energy: false,
    HealthGoal.feed_better: false,
    HealthGoal.stay_motivated: false,
  }, this.render = const [false, false, false, false]});

  @override
  List<Object> get props => [healthGoalMap, render];
}

class GoalUpdated extends GoalState {
  final HealthGoal healthGoal;
  final Map<HealthGoal, bool> healthGoalMap;
  const GoalUpdated(this.healthGoalMap, this.healthGoal);

  @override
  List<Object> get props => [healthGoalMap, healthGoal];
}

class GoalSubmit extends GoalState {
  final User user;
  final String healthGoal;
  const GoalSubmit(this.healthGoal, this.user);
}
