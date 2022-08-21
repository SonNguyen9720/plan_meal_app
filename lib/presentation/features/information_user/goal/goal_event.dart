import 'package:equatable/equatable.dart';

abstract class GoalEvent extends Equatable {
  const GoalEvent();
}

class GoalStarted extends GoalEvent {
  @override
  List<Object> get props => [];
}

class GoalItemAdded extends GoalEvent {
  const GoalItemAdded(this.index);

  final int index;

  @override
  List<Object?> get props => [index];
}

class GoalItemRemoved extends GoalEvent {
  const GoalItemRemoved(this.index);

  final int index;

  @override
  List<Object?> get props => throw UnimplementedError();
}
