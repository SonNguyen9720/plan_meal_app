part of 'marketer_bloc.dart';

abstract class MarketerEvent extends Equatable {
  const MarketerEvent();
}

class MarketerLoadEvent extends MarketerEvent {
  final String groupId;
  final DateTime date;

  const MarketerLoadEvent({required this.groupId, required this.date});

  @override
  List<Object?> get props => [];
}

class MarketerAssignEvent extends MarketerEvent {
  final String groupId;
  final DateTime date;

  const MarketerAssignEvent({required this.groupId, required this.date});

  @override
  List<Object?> get props => [];
}

class MarketerUnassignEvent extends MarketerEvent {
  final String groupId;
  final DateTime date;

  const MarketerUnassignEvent({required this.groupId, required this.date});

  @override
  List<Object?> get props => [];
}
