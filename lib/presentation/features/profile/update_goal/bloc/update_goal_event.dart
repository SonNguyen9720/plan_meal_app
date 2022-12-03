part of 'update_goal_bloc.dart';

abstract class UpdateGoalEvent extends Equatable {
  const UpdateGoalEvent();
}

class UpdateGoalLoadEvent extends UpdateGoalEvent {
  @override
  List<Object?> get props => [];
}
