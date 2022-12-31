part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class NotificationRetrieveEvent extends NotificationEvent {
  final String payload;

  const NotificationRetrieveEvent({required this.payload});

  @override
  List<Object> get props => [payload];
}

class NotificationErrorEvent extends NotificationEvent {
  final String error;

  const NotificationErrorEvent({required this.error});

  @override
  List<Object> get props => [error];
}
