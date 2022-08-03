import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_app/pages/main_page_layout.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:news_app/pages/news_from_push.dart';
import 'package:news_app/services/local_notification_service.dart';
import 'pages/detail_news.dart';
import 'pages/splash_screen.dart';

/// handling notifications when app is in background
Future<void> backgroundHandler(RemoteMessage message) async {
  debugPrint(message.toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(name: defaultFirebaseAppName);
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        routes: {
      "/": (context) => const SplashScreen(),
      "/main_page": (context) => const MainPageLayout(),
      "/detail": (context) => const DetailNewsPage(),
      "/from_push": (context) => const NewsFromPush(),
    });
  }
}
