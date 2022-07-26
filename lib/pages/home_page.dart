import 'package:flutter/material.dart';

import '../managers/database_manager.dart';
import '../news.dart';
import '../widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollCon = ScrollController();
  bool isLoading = false;
  List<News> newsList = [];
  int offset = 0;
  final DatabaseManager _dbManager = DatabaseManager();

  @override
  void initState() {
    super.initState();
    _load();
    _scrollCon.addListener(() {
      if (_scrollCon.offset >= _scrollCon.position.maxScrollExtent &&
          !_scrollCon.position.outOfRange) {
        // reached bottom
        _load();
      }
    });
  }

  void _load() async {
    loading(true);
    List<News> loaded = await _dbManager.getRecentNews(offset);
    newsList.addAll(loaded);
    offset += 10;
    loading(false);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
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

  loading(bool val) {
    setState(() {
      isLoading = val;
    });
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
