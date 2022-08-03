import 'package:flutter/material.dart';
import 'package:news_app/pages/tip_us_page.dart';

import 'blog_posts.dart';
import 'home_page.dart';
import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:news_app/services/local_notification_service.dart';

import '../main.dart';

class MainPageLayout extends StatefulWidget {
  const MainPageLayout({Key? key}) : super(key: key);

  @override
  State<MainPageLayout> createState() => _MainPageLayoutState();
}

class _MainPageLayoutState extends State<MainPageLayout> {
  Widget? mainWidget;
  int _selectedIndex = 0;
  late final FirebaseMessaging _messaging;

@override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    LocalNotificationService.initialize(context);
      registerNotification();
  }

  void registerNotification() async {
    _messaging = FirebaseMessaging.instance;

    _messaging.requestPermission().then((value) {
      debugPrint("ss permission : $value");
    });

    _messaging.getToken().then((token) {
      debugPrint("ss token : $token");
    });

    _messaging.getAPNSToken().then((value) {
      debugPrint("ss APNS token : $value");
    });

    /// it gives us the msg and opens the app from terminated state
    _messaging.getInitialMessage().then((message) {
      if (message != null) {
        Navigator.of(context).pushNamed("/from_push", arguments: message.data["id"]);
      }
    });

    /// Work when app is in foreground
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
      
      LocalNotificationService.display(message);
}
    });

    /// app in background but opened and user taps on Notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
        Navigator.of(context)
          .pushNamed("/from_push", arguments: message.data["id"]);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Image(image: AssetImage("assets/images/MitV_Blue.png")),
          ),
        ),
      ),
      body: mainWidget ?? const HomePage(),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            _selectedIndex = index;
            switch (index) {
              case 1:
                changeTo(const TipUsPage());
                break;
              case 2:
                changeTo(const BlogPostPage());
                break;
              default:
                changeTo(const HomePage());
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Forside"),
            BottomNavigationBarItem(
                icon: Icon(Icons.telegram), label: "Tip Os"),
            BottomNavigationBarItem(
                icon: Icon(Icons.article_outlined), label: "Det Sker"),
          ]),
    );
  }

  // change pages
  void changeTo(Widget newWidget) {
    setState(() {
      mainWidget = newWidget;
    });
  }
}
