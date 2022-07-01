
import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
      Timer(const Duration(seconds: 4),
      (){Navigator.pushReplacementNamed(context, "/main_page");}
  );
    return Material(
      color: Colors.blue.shade900,
      child: const Center(
          child: Image(image: AssetImage("assets/images/MitV_white.png")),
        ),
    );
  }
}