import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    var androidInitialize =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    tz.initializeTimeZones();
    await flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  }

  Future selectNotification(String payload) async {
    //Handle notification tapped logic here
  }

  void scheduleNotificationForShopping(DateTime marketTime) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        12345,
        "Plan Meal",
        "You have shopping tomorrow",
        tz.TZDateTime.from(marketTime, tz.local).subtract(const Duration(days: 1)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                "12345",
                "Plan Meal App",
                channelDescription: 'To remind you shopping')
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
  }
}
