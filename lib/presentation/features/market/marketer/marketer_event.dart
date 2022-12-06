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
