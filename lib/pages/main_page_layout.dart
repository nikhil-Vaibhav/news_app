
import 'package:flutter/material.dart';
import 'package:news_app/pages/tip_us_page.dart';

import 'blog_posts.dart';
import 'home_page.dart';

class MainPageLayout extends StatefulWidget {
  const MainPageLayout({ Key? key }) : super(key: key);

  @override
  State<MainPageLayout> createState() => _MainPageLayoutState();
}

class _MainPageLayoutState extends State<MainPageLayout> {
  Widget? mainWidget;
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
          child: Image(image: AssetImage("assets/images/MitV_Blue.png")),
        ),
      ),
      
      body: mainWidget ?? const HomePage(),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
          onTap: (index) {
            _selectedIndex = index;
            switch (index) {
              case 1:
                changeTo(const TipUsPage());
                break;
              case 2:
                changeTo(const BlogPostPage());
                break;
              default:
                changeTo(const HomePage());
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.telegram), label: "Tip Us"),
            BottomNavigationBarItem(
                icon: Icon(Icons.article_outlined), label: "Det Sker"),
          ]),
    );
  }
  // change pages
    void changeTo(Widget newWidget) {
    setState(() {
      mainWidget = newWidget;
    });
  }
}
