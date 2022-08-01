import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    const InitializationSettings initSettings = InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"),
        iOS: IOSInitializationSettings(
            requestSoundPermission: true,
            requestAlertPermission: true,
            requestBadgePermission: true));
    _plugin.initialize(initSettings);
  }

  static void display(RemoteMessage msg) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
              "mitvmainchannelid", "mitvmainchannel",
              channelDescription: "Channel for breaking news",
              importance: Importance.high,
              priority: Priority.high),
      iOS: IOSNotificationDetails());

      await _plugin.show(id, msg.notification!.title, msg.notification!.body,
          notificationDetails);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}
