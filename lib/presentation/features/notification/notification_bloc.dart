import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  late FlutterLocalNotificationsPlugin localNotification;

  NotificationBloc() : super(NotificationInitial()) {
    localNotification = FlutterLocalNotificationsPlugin();

    on<NotificationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
