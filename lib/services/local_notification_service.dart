import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) {
    const InitializationSettings initSettings = InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"),
        iOS: IOSInitializationSettings(
            requestSoundPermission: true,
            requestAlertPermission: true,
            requestBadgePermission: true));
    _plugin.initialize(initSettings, onSelectNotification: (String? id) async {

        Navigator.of(context).pushNamed("/from_push", arguments: id);
    });
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
          notificationDetails, payload: msg.data["id"]);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}
