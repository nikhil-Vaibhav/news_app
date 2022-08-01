import 'package:flutter/material.dart';

import '../news.dart';
import '../widgets.dart';
import 'package:news_app/widgets.dart';

class DetailNewsPage extends StatefulWidget {
  const DetailNewsPage({Key? key}) : super(key: key);

  @override
  State<DetailNewsPage> createState() => _DetailNewsPageState();
}

class _DetailNewsPageState extends State<DetailNewsPage> {
  @override
  Widget build(BuildContext context) {
    News news = ModalRoute
        .of(context)!
        .settings
        .arguments as News;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Image(image: AssetImage("assets/images/MitV_Blue.png")),
      ),
      body: DetailNews(news),
    );
  }
}
