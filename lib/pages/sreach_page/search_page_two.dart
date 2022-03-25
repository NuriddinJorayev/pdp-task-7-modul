import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_myinsta/functions/temp_data%20.dart';
import 'package:flutter_myinsta/models/myUser.dart';
import 'package:flutter_myinsta/pages/sreach_page/user_widget.dart';
import 'package:flutter_myinsta/services/share_prefs.dart';

class SearchPageTwo extends StatefulWidget {
  final PageController page_control;
  const SearchPageTwo({Key? key, required this.page_control}) : super(key: key);

  @override
  _SearchPageTwoState createState() => _SearchPageTwoState();
}

class _SearchPageTwoState extends State<SearchPageTwo> {
  var control_textfield = TextEditingController();
  int current_index = 0;
  List<MyUser> temp = [];
  bool isWrited = false;
  bool isSearching = false;
  String search_text = '';
  List<Widget> tabs = [
    Tab(text: "Top"),
    Tab(text: "Accounts"),
    Tab(text: "Tags"),
    Tab(text: "Places"),
  ];

  @override
  void initState() {
    super.initState();
    getdata();
  }

  getdata() async {
    var id = await Prefs.Load();
    var data = (await FirebaseFirestore.instance.collection("User").get())
        .docs
        .toList();
    setState(() {
      for (var item in data) {
        if (MyUser.FromJson(item).id != id) {
          if (!_Exist_checker(temp, MyUser.FromJson(item))) {
            setState(() {
              temp.add(MyUser.FromJson(item));
            });
          }
        }
      }
    });
  }

  search_user(String s) async {
    var id = await Prefs.Load();
    if (s.isEmpty) {
      getdata();
      return;
    }

    setState(() => {
          isSearching = true,
          temp = [],
        });
    var data = (await FirebaseFirestore.instance.collection("User").get())
        .docs
        .toList();
    for (var item in data) {
      if (MyUser.FromJson(item)
          .userName
          .toLowerCase()
          .contains(s.toLowerCase())) {
        if (MyUser.FromJson(item).id != id) {
          if (!_Exist_checker(temp, MyUser.FromJson(item)))
            setState(() => temp.add(MyUser.FromJson(item)));
        }
      }
    }
    for (var item in data) {
      if (MyUser.FromJson(item).name.toLowerCase().contains(s.toLowerCase())) {
        if (MyUser.FromJson(item).id !=
            id) if (!_Exist_checker(temp, MyUser.FromJson(item)))
          setState(() => temp.add(MyUser.FromJson(item)));
      }
    }
    setState(() {
      isSearching = false;
      temp;
    });
  }

  bool _Exist_checker(List<MyUser> l, MyUser u) {
    for (var item in l) {
      if (item.operator(u)) {
        return true;
      }
    }
    return false;
  }

  go_page(int i, MyUser user) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (widget.page_control.hasClients) {
        Temp_data.user = user;
        widget.page_control.animateToPage(i,
            duration: Duration(milliseconds: 1), curve: Curves.linear);
      }
    });
  }

  Future<bool> _PopScope() async {
    print("poped");
    Navigator.pop(context);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var allsize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _PopScope,
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            elevation: 1.5,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                go_page(0, temp[current_index]);
              },
              icon: Icon(AntDesign.arrowleft, color: Colors.black),
            ),
            leadingWidth: 30,
            title: MytextField(),
            bottom: TabBar(
                indicatorColor: Colors.black,
                indicatorWeight: 1,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black.withAlpha(160),
                labelPadding: EdgeInsets.symmetric(horizontal: 0),
                labelStyle:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                tabs: tabs),
          ),
          body: Container(
            child: TabBarView(
              children: [
                Container(
                    color: Colors.white,
                    child: !isSearching
                        ? ListView.builder(
                            itemCount: temp.length + 1,
                            itemBuilder: (con, int i) {
                              if (i == 0) {
                                return first_widget();
                              }
                              return InkWell(
                                onTap: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  go_page(2, temp[i - 1]);
                                },
                                child: Container(
                                  width: allsize.width,
                                  child: User_Widgets.itemOfUser(
                                      temp[i - 1].userName,
                                      temp[i - 1].name,
                                      temp[i - 1].user_image,
                                      isround_randim()),
                                ),
                              );
                            },
                          )
                        : Column(
                            children: [
                              loading_widget(search_text),
                            ],
                          )),
                Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        User_Widgets.itemOfUser(
                            "Nuriddin",
                            "just do it\nthis task",
                            "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
                            isround_randim()),
                        User_Widgets.itemOfUser(
                            "Nuriddin",
                            "just do it",
                            "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
                            true),
                        User_Widgets.itemOfUser(
                            "Nuriddin", "just do it", "", true),
                      ],
                    )),
                Container(color: Colors.greenAccent),
                Container(color: Colors.greenAccent),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loading_widget(String s) => Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(22, 20, 0, 20),
              child: SizedBox(
                height: 15,
                width: 15,
                child: CircularProgressIndicator(
                  color: Colors.black87,
                  strokeWidth: 2,
                ),
              ),
            ),
            SizedBox(width: 30),
            Expanded(
                child: Text(
              '''Sreaching for "$s"...''',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 17,
                  overflow: TextOverflow.ellipsis),
              maxLines: 4,
            ))
          ],
        ),
      );

  bool isround_randim() {
    Random r = Random();
    var number = r.nextInt(100) + 1;
    return number % 2 == 0;
  }

  Widget first_widget() => Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Recent",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w900),
            ),
            Text(
              "See All",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      );
  // textfield
  Widget MytextField() => Container(
        height: 38,
        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.3),
            borderRadius: BorderRadius.circular(10)),
        child: TextField(
          onChanged: (s) {
            if (s.isEmpty) {
              setState(() => temp = []);
              getdata();
              isSearching = false;
            } else
              setState(() {
                isWrited = s.isNotEmpty;
                isSearching = true;
                search_text = s;
                search_user(s);
              });
          },
          controller: control_textfield,
          strutStyle: StrutStyle(height: 1.5),
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              letterSpacing: .8,
              height: 1.5),
          cursorColor: Colors.black,
          cursorWidth: .8,
          autofocus: true,
          textAlignVertical: TextAlignVertical.top,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0),
              suffixIcon: isWrited
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          control_textfield.clear();
                          isWrited = false;
                          setState(() => temp = []);
                          getdata();
                          isSearching = false;
                        });
                      },
                      child: Icon(
                        Feather.x,
                        color: Colors.black,
                        size: 17,
                      ))
                  : SizedBox.shrink(),
              border: InputBorder.none,
              hintText: "Search",
              hintStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black.withAlpha(150),
                letterSpacing: .8,
              )),
        ),
      );
}
