import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:news_app/services/local_notification_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late final FirebaseMessaging _messaging;

  @override
  void initState() {
    super.initState();
    registerNotification();
  }

  void registerNotification() async {


    _messaging = FirebaseMessaging.instance;

    _messaging.requestPermission().then((value) {
      debugPrint("$value");
    });

    _messaging.getToken().then((token) {
      debugPrint("$token");
    });

    _messaging.getAPNSToken().then((value) {
      debugPrint("$value");
    });

    /// it gives us the msg and opens the app from terminated state
    _messaging.getInitialMessage().then((message) {
      if(message != null) {
        Navigator.of(context).pushNamed("/main_page");
      }
    });

    /// Work when app is in foreground
    FirebaseMessaging.onMessage.listen((message){
      if(message.notification != null) {

      }
      LocalNotificationService.display(message);

    });

    /// app in background but opened and user taps on Notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      Navigator.of(context).pushNamed("/main_page");
    });
  }

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, "/main_page");
    });
    return Material(
      color: const Color(0xFF12213f),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(1.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Image(image: AssetImage("assets/images/MitV_White.png")),

                SizedBox(
                  height: 10
                ),

                Text(
                  "Lokale Nyheder hele døgnet!",
                  style: TextStyle(
                    fontSize: 20,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
