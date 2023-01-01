import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class PushNotificationService {
  static Future<void> init() async {
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    final settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (kDebugMode) {
      print("Permission granted: ${settings.authorizationStatus}");
    }
  }

  Future<String?> getToken() async {
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    String? token = await firebaseMessaging.getToken();
    if (kDebugMode) {
      print("Registration Token = $token");
    }
    return token;
  }
}

class PushNotification {
  final String? title;
  final String? body;

  PushNotification({this.title, this.body});
}
