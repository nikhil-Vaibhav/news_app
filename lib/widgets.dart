

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
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.contain,
                  image: NetworkImage(news.thumbnailImage!)),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  news.category,
                  style: const TextStyle(color: Colors.red, fontSize: 13),
                ),
              ),
              const SizedBox(height: 10),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    news.title,
                    style: const TextStyle(color: Colors.black, fontSize: 21),
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
      // Container(
      //   padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      //   alignment: Alignment.centerLeft,
      //   child: Text(
      //     news.content,
      //     style: const TextStyle(color: Colors.black, fontSize: 15),
      //   ),
      // ),
      Container(
          // padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
          alignment: Alignment.centerLeft,
          child: Html.fromDom(document: getDom(news.content))
          ),
    ]),
  );
}


dom.Document getDom(String t) {
  return parse(t);
}

