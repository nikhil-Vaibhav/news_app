
import 'package:flutter/material.dart';

import '../managers/database_manager.dart';
import '../news.dart';
import '../widgets.dart';

class BlogPostPage extends StatefulWidget {
  const BlogPostPage({ Key? key }) : super(key: key);

  @override
  State<BlogPostPage> createState() => _BlogPostPageState();
}

class _BlogPostPageState extends State<BlogPostPage> {
  final ScrollController _scrollCon = ScrollController();
  bool isLoading = false;
  List<News> newsList = [];
  int offset = 1;
  final DatabaseManager _dbManager = DatabaseManager();
  
  @override
  void initState() {
    super.initState();
    loadData();
    _scrollCon.addListener(() {
      if (_scrollCon.offset >= _scrollCon.position.maxScrollExtent &&
          !_scrollCon.position.outOfRange) {
        //reached bottom
        loadData();
      }
    });
  }

  void loadData() async {
    loading(true);
    List<News> loaded = await _dbManager.getAllBlogPosts(offset);
    newsList.addAll(loaded);
    offset += 10;
    loading(false);
  }

    loading(bool val) {
    setState(() {
      isLoading = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child:  Stack(
        children: [
          if(newsList.isNotEmpty) ...[
            _listBuilder()
          ] else ...[
            const Center(child: CircularProgressIndicator())
          ],
          if(isLoading && newsList.isNotEmpty)...[
            const Align(
              alignment: Alignment.bottomCenter,
              child: LinearProgressIndicator())
          ]
        ],
      ),
    );
  }
   // Get data from API and build news items
  Widget _listBuilder() {
    return ListView.builder(
        controller: _scrollCon,
        itemCount: newsList.length,
        itemBuilder: ((context, index) {
          return NewsItem(context, newsList[index]);
        }));
  }
}