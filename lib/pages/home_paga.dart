
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myinsta/pages/my_feed_page.dart';
import 'package:flutter_myinsta/pages/my_likes_page.dart';
import 'package:flutter_myinsta/pages/my_profile_page.dart';
import 'package:flutter_myinsta/pages/my_search_page.dart';
import 'package:flutter_myinsta/pages/my_upload_page.dart';

class Home extends StatefulWidget {
  final String id = "home_page";
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var page_control = PageController(initialPage: 0);
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: PageView(
        onPageChanged: (int index){
          setState(() {
            _currentIndex = index;
          });
        },
        controller: page_control,
        children: [
          MyFeedPage(),
          MySearchPage(),
          MyUploadPage(),
          MyLikesPage(),
          MyProfilePage()
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _currentIndex,
        onTap: (int index){
          setState(() {
            _currentIndex = index;
            page_control.animateToPage(
              _currentIndex,
               duration: Duration(microseconds: 500), curve: Curves.bounceIn);
          });
        },
        activeColor: Color.fromARGB(255, 245, 96, 63),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded )),
          BottomNavigationBarItem(icon: Icon(Icons.search )),
          BottomNavigationBarItem(icon: Icon(Icons.add_box )),
          BottomNavigationBarItem(icon: Icon(Icons.favorite)),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle )),
        ],
      )
    );
  }
}