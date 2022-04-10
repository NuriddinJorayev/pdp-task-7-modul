import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_myinsta/functions/temp_data%20.dart';
import 'package:flutter_myinsta/models/myUser.dart';
import 'package:flutter_myinsta/models/post.dart';
import 'package:flutter_myinsta/services/data_service.dart';
import 'package:flutter_myinsta/services/share_prefs.dart';
import 'package:flutter_myinsta/widgets/profile_widgets/users_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OtherUserview extends StatefulWidget {
  final PageController pageController;

  const OtherUserview({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  _OtherUserviewState createState() => _OtherUserviewState();
}

class _OtherUserviewState extends State<OtherUserview> {
  MyUser? user;
  var key1 = GlobalKey();
  var key2 = GlobalKey();
  var key3 = GlobalKey();
  List<Post> temp_grid_list = [];
  bool isappbar = false;
  bool isfriend = false;
  bool istoped = true;
  int toped = 0;
  int lastposition = 0;
  bool isfollowed = false;
  bool follow_load = false;

  var s_control = ScrollController();
  var s_control2 = ScrollController();
  var r_control = RefreshController();
  var scrollPhysics = ScrollPhysics();
  int scroll_posision = 0;
  List fadeList_name = [
    "factlat_boom",
    "abadiy_hislar",
    "holisligim",
    "oper_rasmiy"
  ];

  List fadeList_bio = ["FACTS BOOM", "abadiy_hislar", "#Sabr", "OPER UZ"];
  List<Tab> myTabs = [
    Tab(icon: Icon(Icons.grid_on_rounded, color: Colors.black)),
    Tab(icon: Icon(Feather.play, color: Colors.black)),
    Tab(icon: Icon(Icons.person_pin_outlined, color: Colors.black)),
  ];
  bool isloading = false;

  @override
  void initState() {
    filldes();
    super.initState();
    setState(() {
      user = Temp_data.user;
    });

    s_control.addListener(() {
      print(s_control.offset);
      if (s_control.offset.toInt() < -2) {
        setState(() {
          s_control.animateTo(0.0,
              duration: Duration(microseconds: 100), curve: Curves.linear);
        });
      }

      if (s_control.offset.toInt() <= 0) {
        if (toped == 2 || lastposition == 0) {
          loading_prosses();
        } else {
          s_control.animateTo(0.0,
              duration: Duration(microseconds: 100), curve: Curves.linear);
          setState(() {
            istoped = false;
          });
          setState(() {
            istoped = true;
            toped++;
          });
        }
      } else {
        setState(() {
          lastposition = 1;
        });
      }
      var i = (isfriend
                  ? key1.currentContext!.size!.height
                  : 0.0 + key2.currentContext!.size!.height)
              .toInt() +
          56;
      if (i == s_control.offset.toInt() ||
          i == s_control.offset.toInt() + 1 ||
          i == s_control.offset.toInt() - 1) {
        setState(() {
          scroll_posision = s_control.offset.toInt();
          isappbar = true;
        });
      } else {
        setState(() {
          scroll_posision = s_control.offset.toInt();
          if (i > s_control.offset.toInt()) {
            isappbar = false;
          } else {
            isappbar = true;
          }
        });
      }
    });

    s_control2.addListener(() {
      setState(() {
        if (s_control2.offset.toInt() == 0) {
          scrollPhysics = NeverScrollableScrollPhysics();
        } else {
          scrollPhysics = ScrollPhysics();
        }
      });
    });
  }

  filldes() async {
    var id = await Prefs.Load();
    DataService.get_posts(user!.id).then((value) {
      setState(() {
        temp_grid_list = value;
      });
    });

    var data =
        await FirebaseFirestore.instance.collection("User").doc(user!.id).get();
    var t_user = MyUser.FromJson(data.data());
    for (var e in t_user.followers) {
      if (e.id == id) {
        setState(() {
          isfollowed = true;
        });
        break;
      }
    }
  }

  Future loading_prosses() async {
    setState(() => isloading = true);
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      isloading = false;
      toped = 0;
      lastposition = s_control.offset.toInt();
    });
  }

  go_page(int i) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (widget.pageController.hasClients) {
        widget.pageController.animateToPage(i,
            duration: Duration(milliseconds: 1), curve: Curves.linear);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var allsize = MediaQuery.of(context).size;
    var appbar_h = AppBar().preferredSize.height;
    var statusbar_h = MediaQuery.of(context).viewPadding.top;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                go_page(1);
              },
              icon: Icon(AntDesign.arrowleft, color: Colors.black),
            ),
            title: Text(user!.userName,
                // widget.username,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    letterSpacing: .6)),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert_outlined,
                    color: Colors.black,
                  ))
            ],
            shape: scroll_posision >= 1
                ? UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: .8))
                : null),
        body: Stack(
          children: [
            SingleChildScrollView(
              controller: s_control,
              physics: istoped
                  ? BouncingScrollPhysics(parent: ClampingScrollPhysics())
                  : NeverScrollableScrollPhysics(),
              dragStartBehavior: DragStartBehavior.start,
              child: Container(
                height: allsize.height + (allsize.height - 106),
                width: allsize.width,
                child: Column(
                  children: [
                    Loading_panel(),
                    Container(
                      key: key2,
                      child: UserView.User_post_follow_following(
                          user!.user_image,
                          user!.name,
                          user!.bio,
                          user!.posts.toString(),
                          user!.followers.length.toString(),
                          user!.following.length.toString(),
                          () {},
                          () {},
                          () {}),
                    ),
                    SizedBox(height: 5),
                    // follow, massage and icon button
                    follow_message_button(),
                    // friend users
                    isfriend
                        ? Container(
                            key: key1,
                            height: allsize.height * .31,
                            width: allsize.width,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Suggested for you",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700)),
                                      Text("See All",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700)),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: allsize.height * .25,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: fadeList_name.length,
                                    itemBuilder: (con, int i) {
                                      if (i == 0) {
                                        return Row(
                                          children: [
                                            SizedBox(width: 10),
                                            _follow_view(fadeList_name[i],
                                                fadeList_bio[i])
                                          ],
                                        );
                                      } else if (i ==
                                          fadeList_name.length - 1) {
                                        return Row(
                                          children: [
                                            _follow_view(fadeList_name[i],
                                                fadeList_bio[i]),
                                            SizedBox(width: 10),
                                          ],
                                        );
                                      }
                                      return _follow_view(
                                          fadeList_name[i], fadeList_bio[i]);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox.shrink(),
                    SizedBox(height: 10),
                    !isappbar
                        ? TabBar(
                            key: key3,
                            tabs: myTabs,
                            indicatorColor: Colors.black,
                            indicatorWeight: 1.6,
                          )
                        : SizedBox.shrink(),
                    Expanded(
                      child: TabBarView(children: [
                        Container(
                            height:
                                allsize.height - (appbar_h + statusbar_h + 48),
                            color: Colors.white,
                            margin: EdgeInsets.only(top: 2.5),
                            child: temp_grid_list.isNotEmpty
                                ? GridView.count(
                                    controller: s_control2,
                                    physics: scrollPhysics,
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 1.5,
                                    crossAxisSpacing: 1.5,
                                    children: temp_grid_list
                                        .map((e) =>
                                            _item_of_grid_view(e.post_images))
                                        .toList(),
                                  )
                                : Container(
                                    alignment: Alignment.topCenter,
                                    child: Text("no data"),
                                  )),
                        Container(color: Colors.amber),
                        Container(color: Colors.deepOrange),
                      ]),
                    )
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  color: Colors.white,
                  child: isappbar
                      ? TabBar(
                          tabs: myTabs,
                          indicatorColor: Colors.black,
                        )
                      : SizedBox.shrink(),
                ),
                Expanded(child: SizedBox.shrink())
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget Loading_panel() => Container(
        height: isloading ? 50 : 0,
        width: double.infinity,
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          color: Colors.grey[400],
          strokeWidth: 2,
        ),
      );

  Widget follow_message_button() => Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: [
            mybutton(
              "Follow",
            ),
            SizedBox(width: 5),
            mybutton("Message"),
            SizedBox(width: 5),
            GestureDetector(
              onTap: () {
                setState(() {
                  isfriend = !isfriend;
                });
              },
              child: Container(
                height: 35,
                width: 31,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(4),
                    color:
                        isfriend ? Colors.black.withAlpha(25) : Colors.white),
                child: Transform(
                  transform: Matrix4.rotationY(3),
                  alignment: Alignment.center,
                  child: follow_load
                      ? Container(
                          height: 29,
                          width: 29,
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 44, 42, 42),
                            strokeWidth: 2,
                          ),
                        )
                      : Icon(
                          isfriend
                              ? Icons.person_add_alt_1
                              : FlutterIcons.user_plus_fea,
                          size: 17,
                        ),
                ),
              ),
            )
          ],
        ),
      );

  Widget mybutton(text) => Expanded(
        child: GestureDetector(
          onTap: () async {
            setState(() => follow_load = true);

            if (text == "Follow") {
              setState(() {
                isfollowed = !isfollowed;
              });
              if (isfollowed) {
                await DataService.following_add(user!)
                    .then((value) => Refresher(user!.id));
              } else {
                await DataService.following_del(user!)
                    .then((value) => Refresher(user!.id));
              }
            }
            setState(() => follow_load = false);
          },
          child: Container(
              height: 35,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: (text == "Follow" || text == "Following")
                    ? isfollowed
                        ? Colors.white
                        : Colors.blue[600]
                    : Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                    color: (text == "Follow" || text == "Following")
                        ? !isfollowed
                            ? Colors.blue[600]!
                            : Colors.grey
                        : Colors.grey,
                    width: 1),
              ),
              child: (text == "Follow" || text == "Following")
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(isfollowed ? text + "ing " : text,
                            style: TextStyle(
                                color: isfollowed ? Colors.black : Colors.white,
                                fontSize: 16,
                                fontWeight: !isfollowed
                                    ? FontWeight.w600
                                    : FontWeight.w700)),
                        isfollowed
                            ? Icon(Icons.keyboard_arrow_down)
                            : SizedBox.shrink()
                      ],
                    )
                  : Text(text,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700))),
        ),
      );

  Widget _follow_view(name, bio) => Container(
        margin: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
        width: MediaQuery.of(context).size.width * .38,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(5),
            color: Colors.white),
        child: Column(
          children: [
            SizedBox(height: 10),
            _circle_avatar(MediaQuery.of(context).size.width * .38),
            SizedBox(height: 10),
            Text(name,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    letterSpacing: .8)),
            SizedBox(height: 2),
            Text(bio,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            Expanded(child: SizedBox.shrink()),
            Container(
              height: 30,
              width: MediaQuery.of(context).size.width * .34,
              margin: EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.blue[600],
              ),
              child: Text("Follow",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
            )
          ],
        ),
      );

  Widget _circle_avatar(double d) => Container(
        height: d - 80,
        width: d - 80,
        alignment: Alignment.center,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: Colors.grey[300]),
        child: Icon(
          Icons.person_outline_outlined,
          color: Colors.grey,
          size: 40,
        ),
      );

  Refresher(String id) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var get_user = await firestore.collection("User").doc(id).get();
    var u = MyUser.FromJson(get_user.data());
    setState(() {
      Temp_data.user = u;
      user = u;
    });
  }

  Widget _item_of_grid_view(List url) {
    bool is_img = !url[0].toString().contains(".mp4");

    if (is_img)
      return Container(
        decoration: BoxDecoration(
            image:
                DecorationImage(image: NetworkImage(url[0]), fit: BoxFit.fill)),
      );
    return Container(
      color: Colors.grey,
    );
  }
}
