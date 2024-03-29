import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../news.dart';

class DatabaseService {
  final String recentPageID = "1499";
  final String requiredFields = "id,title,content,categories,yoast_head_json,link";

  //private constructor
  DatabaseService._internal();

  //singleton
  static final DatabaseService _databaseService = DatabaseService._internal();

  factory DatabaseService() {
    return _databaseService;
  }

  // for home page getting recent news
  Future<List<News>> getRecentNewsPosts(int offset) async {
    var request = http.Request(
        'GET',
        Uri.parse(baseURL +
            'posts?_fields=$requiredFields&offset=$offset&per_page=10&page_id=$recentPageID'));
    http.StreamedResponse response = await request.send();

    List<dynamic> json = jsonDecode(await response.stream.bytesToString());

    List<News> newsList = json.map((e) => News.fromJSON(e)).toList();
    for (News news in newsList) {
      news.category = await getCategory(int.parse(news.category));
    }
    debugPrint("Loaded : ${newsList.length}");
    return newsList;
  }

  // getting name of category
  Future<String> getCategory(int catID) async {
    var request = http.Request('GET', Uri.parse(baseURL + 'categories/$catID'));
    http.StreamedResponse response = await request.send();

    dynamic json = jsonDecode(await response.stream.bytesToString());
    return json["name"];
  }

  // for blog posts page
  Future<List<News>> getAllBlogPosts(int offset) async {
    var request = http.Request(
        'GET', Uri.parse(baseURL + 'posts?_fields=$requiredFields&categories=23305&offset=$offset&per_page=10'));
    http.StreamedResponse response = await request.send();

    List<dynamic> json = jsonDecode(await response.stream.bytesToString());

    List<News> newsList = json.map((e) => News.fromJSON(e)).toList();
    for (News news in newsList) {
      news.category = await getCategory(int.parse(news.category));
    }
    return newsList;
  }

  Future<News> getNewsArticle(String id) async {
    var request = http.Request(
        'GET', Uri.parse(baseURL + 'posts/$id'));
    http.StreamedResponse response = await request.send();

    var json = jsonDecode(await response.stream.bytesToString());
    // debugPrint("Loaded: $json");
    News news = News.fromJSON(json);
    news.category = await getCategory(int.parse(news.category));
    return news;
  }
}
