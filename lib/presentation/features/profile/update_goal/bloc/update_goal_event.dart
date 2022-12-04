part of 'update_goal_bloc.dart';

abstract class UpdateGoalEvent extends Equatable {
  const UpdateGoalEvent();
}

class UpdateGoalLoadEvent extends UpdateGoalEvent {
  @override
  List<Object?> get props => [];
}

class UpdateGoalSendEvent extends UpdateGoalEvent {
  final String currentWeight;
  final String desiredWeight;

  const UpdateGoalSendEvent({required this.currentWeight, required this.desiredWeight});

  @override
  List<Object?> get props => [currentWeight, desiredWeight];

}
