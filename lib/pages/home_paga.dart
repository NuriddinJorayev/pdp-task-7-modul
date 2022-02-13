// ignore: unused_import
import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_myinsta/functions/main_page_controller.dart';
import 'package:flutter_myinsta/functions/page_control.dart';
import 'package:flutter_myinsta/functions/page_opener_push.dart';
import 'package:flutter_myinsta/functions/permissions.dart';
// ignore: unused_import
import 'package:flutter_myinsta/pages/camera_page.dart';
import 'package:flutter_myinsta/pages/contect_page.dart';
import 'package:flutter_myinsta/pages/my_feed_page.dart';
import 'package:flutter_myinsta/pages/my_likes_page.dart';
import 'package:flutter_myinsta/pages/my_profile_page.dart';
import 'package:flutter_myinsta/pages/my_search_page.dart';
import 'package:flutter_myinsta/pages/my_upload_page.dart';
import 'package:flutter_myinsta/pages/profile_pages.dart/setting_page.dart';

class Home extends StatefulWidget {
  final String id = "home_page";
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var page_control = PageController(initialPage: 0);
  var main_page_control = PageController(initialPage: 1);
  var settting_control = PageController(initialPage: 0);
  ScrollPhysics scroll = NeverScrollableScrollPhysics();

  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    initialize();
    MyPermission_status.RequestPermission();
    MyPage_Controller.set(page_control);
    MyMain_page_control.set(main_page_control);
    scroll = ScrollPhysics();
  }

  var cam;
  initialize() async {
    cam = await availableCameras();
    if (cam != null) {
      setState(() {});
    }
  }

  Future<bool> system_callback() async {
    if (main_page_control.page!.toInt() != 1) {
      setState(() {
        MyMain_page_control.go_page(1);
      });
      return false;
    }
    return true;
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    if (_currentIndex == 0) {
      scroll = ScrollPhysics();
    } else {
      scroll = NeverScrollableScrollPhysics();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: system_callback,
      child: Scaffold(
        body: PageView(
          controller: main_page_control,
          physics: scroll,
          children: [
            MyUploadPage(selectText: "STORY"),
            Scaffold(
                body: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  onPageChanged: (i) {
                    setState(() {
                      _currentIndex = i;
                    });
                  },
                  controller: page_control,
                  children: [
                    MyFeedPage(),
                    MySearchPage(),
                    SizedBox.shrink(),
                    MyLikesPage(),
                    PageView(
                      controller: settting_control,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        MyProfilePage(
                            userName: "Nuriddin",
                            settting_control: settting_control),
                        SettingPage(settting_control: settting_control)
                      ],
                    )
                  ],
                ),
                bottomNavigationBar: CupertinoTabBar(
                  currentIndex: _currentIndex,
                  onTap: (int index) {
                    if (index != 0) {
                      setState(() {
                        scroll = NeverScrollableScrollPhysics();
                      });
                    }
                    if (index == 2) {
                      PagePush.Push(context, MyUploadPage(selectText: "POST"));
                      return;
                    }

                    setState(() {
                      _currentIndex = index;
                    });
                    WidgetsBinding.instance?.addPostFrameCallback((_) {
                      if (page_control.hasClients) {
                        page_control.animateToPage(_currentIndex,
                            duration: Duration(milliseconds: 1),
                            curve: Curves.easeInOut);
                      }
                    });
                  },
                  activeColor: Colors.black,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(MaterialCommunityIcons.home_outline)),
                    BottomNavigationBarItem(icon: Icon(Icons.search)),
                    BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined)),
                    BottomNavigationBarItem(icon: Icon(Icons.favorite)),
                    BottomNavigationBarItem(icon: Icon(Icons.account_circle)),
                  ],
                )),
            ContactPage()
          ],
        ),
      ),
    );
  }
}
