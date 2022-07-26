import 'package:flutter/material.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/pages/main_page_layout.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'pages/detail_news.dart';
import 'pages/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    OneSignal.shared.setAppId(oneSignalAppId);

    // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      debugPrint("Accepted permission: $accepted");
    });
    
    return MaterialApp(routes: {
      "/": (context) => const SplashScreen(),
      "/main_page": (context) => const MainPageLayout(),
      "/detail": (context) => const DetailNewsPage(),
    });
  }
}
