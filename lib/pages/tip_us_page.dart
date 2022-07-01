import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class TipUsPage extends StatefulWidget {
  const TipUsPage({Key? key}) : super(key: key);

  @override
  State<TipUsPage> createState() => _TipUsPageState();
}

class _TipUsPageState extends State<TipUsPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Container(
                alignment: Alignment.center,
                child: RichText(
                  text: const TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                            text:
                                "Du er altid meget velkommen til at sende os pressemeddelelser eller kontakte vores redaktion på"),
                        TextSpan(
                            text: " red@mitv.dk.",
                            style: TextStyle(color: Colors.blue)),
                        TextSpan(
                            text: "\n\nSker der noget nu og her?",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                "\n\nBrug vores tip-knap og send os en besked.")
                      ]),
                )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _openFb();
              },
              child: const Text("Tip Us"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
            ),
            const SizedBox(height: 20),
            Container(
                alignment: Alignment.center,
                child: RichText(
                  text: const TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                            text:
                                "Ender vi med at bruge dit tip, kvitterer vi selvfølgelig med en lille gave fra byen som tak!"),
                        TextSpan(
                            text: "\n\nKontakt:",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: "\nDu kan altid kontakte os på mail"),
                        TextSpan(
                            text: " Red@Mitv.dk \n",
                            style: TextStyle(color: Colors.blue)),
                        TextSpan(
                            text: "eller på telefon 42 74 42 74. (Kun opkald)")
                      ]),
                ))
          ])),
    );
  }

  void _openFb() async {
    String fbURL;
    if (Platform.isIOS) {
      fbURL = "fb://profile/$fbPageId";
    } else {
      fbURL = "fb://page/$fbPageId";
    }

    // fb page URI for opening in web
    String fallbackURL = "https://www.facebook.com/$fbPageId";

    try {
      Uri bundleUri = Uri.parse(fbURL);

      if (await canLaunchUrl(bundleUri)) {
        //launch in app
        debugPrint("Launching in app...");
        
        launchUrl(bundleUri);
      } else {
        //launch in web
        debugPrint("Launching in web...");
        await launchUrl(Uri.parse(fallbackURL),
            mode: LaunchMode.externalApplication);
      }
    } catch (e, st) {
      debugPrint(e.toString());
    }
  }
}
