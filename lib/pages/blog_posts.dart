
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
  int offset = 0;
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
          var news = newsList[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/detail", arguments: news);
            },
            child: Card(
                elevation: 4,
                child: Container(
                  padding:
                  const EdgeInsets.only(left: 12, right: 12, top: 0, bottom: 0),
                  child: Row(
                    children: [
                      Image(
                          height: 100,
                          width: 100,
                          fit: BoxFit.contain,
                          image: NetworkImage(news.thumbnailImage!)),
                      const SizedBox(width: 20),
                      Flexible(

                          child: Text(
                            news.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                )),
          );
        }));
  }
}