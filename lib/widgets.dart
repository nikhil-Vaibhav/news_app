import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' show parse;

import 'news.dart';

Widget NewsItem(BuildContext context, News news) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, "/detail", arguments: news);
    },
    child: Card(
        elevation: 4,
        child: Container(
          padding:
              const EdgeInsets.only(left: 12, right: 12, top: 18, bottom: 8),
          child: Column(
            children: [
              Image(
                  height: 170,
                  width: double.infinity,
                  fit: BoxFit.fill,
                  image: NetworkImage(news.thumbnailImage!)),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  news.category,
                  style: const TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.red,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    news.title,
                    style: const TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                        fontSize: 21,
                        fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        )),
  );
}

Widget DetailNews(News news) {
  return SingleChildScrollView(
    child: Column(children: [
      Image(
          height: 250,
          width: double.infinity,
          fit: BoxFit.contain,
          image: NetworkImage(news.thumbnailImage!)),
      const SizedBox(
        height: 20,
      ),

      // category
      Container(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
        alignment: Alignment.centerLeft,
        child: Text(
          news.category,
          style: const TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      const SizedBox(height: 20),

      //Title
      Container(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
        alignment: Alignment.centerLeft,
        child: Text(
          news.title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(height: 20),

      //Content

      Container(
          // padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
          alignment: Alignment.centerLeft,
          child: Html.fromDom(document: getDom(news.content))),

      const SizedBox(height: 30),

      getFooter()
    ]),

  );
}

dom.Document getDom(String t) {
  return parse(t);
}

Widget getFooter() {
  return Container(
    width: double.infinity,
    height: 250,
    color: const Color(0XFF070707),
    padding: EdgeInsets.all(24),
    child: Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Align(
          child: Text(
            "Lokale nyheder hele døgnet!\nTip os altid gerne her i appen, eller på telefon 42 74 42 74 ",

            style: TextStyle(
              fontFamily: 'Montserrat',
                fontSize: 15,
                fontStyle: FontStyle.italic,
                color: Colors.white),
          ),
        ),
        SizedBox(height: 20),
        Image(
            height: 120,
            width: 200,
            image: AssetImage("assets/images/Footer_logo.png")),

      ],
    )),
  );
}
