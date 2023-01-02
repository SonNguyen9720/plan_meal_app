part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationIndexed extends NotificationState {
  final int index;

  const NotificationIndexed(this.index);

  @override
  List<Object> get props => [index];
}
