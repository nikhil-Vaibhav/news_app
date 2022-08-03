import 'package:flutter/material.dart';
import 'package:news_app/managers/database_manager.dart';
import 'package:news_app/news.dart';
import 'package:news_app/pages/detail_news.dart';
import 'package:news_app/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsFromPush extends StatefulWidget {
  const NewsFromPush({Key? key}) : super(key: key);

  @override
  State<NewsFromPush> createState() => _NewsFromPushState();
}

class _NewsFromPushState extends State<NewsFromPush> {

  late News news;
  bool loading = false;

  @override
  void initState() {
    super.initState();
//loadNews("4268");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    String? id = ModalRoute
        .of(context)!
        .settings
        .arguments as String?;

    loadNews(id!);
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(right: 40),
            child: Image(image: AssetImage("assets/images/MitV_Blue.png")),
          ),
        ),
      ),
      body: loading ? const Center(child: CircularProgressIndicator(),) :
          DetailNews(news)

    );
  }

  void loadNews (String id) async {
setState((){
loading = true;
});
    news = await DatabaseManager().getNewsArticle(id);
setState((){
loading = false;
});
  }
}
