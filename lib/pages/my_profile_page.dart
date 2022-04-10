import 'dart:typed_data';

import 'package:animated_shimmer/animated_shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_myinsta/functions/page_control.dart';
import 'package:flutter_myinsta/models/myUser.dart';
import 'package:flutter_myinsta/models/post.dart';
import 'package:flutter_myinsta/pages/my_follow_page.dart';
import 'package:flutter_myinsta/pages/my_posts_view_page.dart';
import 'package:flutter_myinsta/pages/profile_pages.dart/edite_profile_page.dart';
import 'package:flutter_myinsta/services/data_service.dart';
import 'package:flutter_myinsta/services/share_prefs.dart';
import 'package:flutter_myinsta/widgets/loading_widget.dart';
import 'package:flutter_myinsta/widgets/profile_widgets/discover_people.dart';
import 'package:flutter_myinsta/widgets/profile_widgets/users_view.dart';
import 'package:flutter_myinsta/widgets/sheets/profile_menu.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class MyProfilePage extends StatefulWidget {
  final String id = "my_profile_page";
  final PageController settting_control;
  const MyProfilePage({Key? key, required this.settting_control})
      : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  String user_image = "";
  String userName = "";
  String name = "";
  String bio = "";
  String myuserId = "";
  List<MyUser> followers = [];
  List<MyUser> following = [];
  bool isLoading = false;
  List<bool> follow_button_isSelected = [
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  bool panelIsOpen = false;
  List tempImageList = [];
  int tabBar_select_index = 0;
  bool user_view = true;
  List<Post> my_all_posts = [];

  @override
  void initState() {
    id_field();
    _runData();
    super.initState();
    initialize();
    initi_filds();
  }

  id_field() async {
    myuserId = await Prefs.Load();
  }

  initi_filds() async {
    setState(() {
      isLoading = true;
    });
    if (mounted) {
      try {
        var user = MyUser.FromJson(await DataService.getData());
        var get_all_posts = await DataService.get_posts(await Prefs.Load());
        setState(() {
          user_image =
              user.user_image.isNotEmpty ? user.user_image : user_image;
          userName = user.userName.isNotEmpty ? user.userName : userName;
          name = user.name.isNotEmpty ? user.name : name;
          bio = user.bio.isNotEmpty ? user.bio : bio;
          followers = user.followers.isNotEmpty ? user.followers : followers;
          following = user.following.isNotEmpty ? user.following : following;
          // ignore: unnecessary_null_comparison
          my_all_posts = get_all_posts != null ? get_all_posts : [];
        });
      } catch (e) {}
    }
    setState(() {
      isLoading = false;
    });
  }

  var cam;
  initialize() async {
    cam = await availableCameras();
    if (cam != null) {
      setState(() {
        cam = cam;
      });
    }
  }

  Future<bool> system_back_function() async {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (MyPage_Controller.pageController!.hasClients) {
        MyPage_Controller.pageController!.animateToPage(0,
            duration: Duration(milliseconds: 1), curve: Curves.easeInOut);
      }
    });
    return false;
  }

  _runData() async {
    // ignore: unused_local_variable
    // var id = await Prefs.Load();
    // var user_data = MyUser.FromJson((await DataService.getData()));

    setState(() => isLoading = true);
    initi_filds();
    setState(() => isLoading = false);
  }

  @override
  void didChangeDependencies() {
    // setState(() => isLoading = true);
    // initi_filds();
    // setState(() => isLoading = false);
    super.didChangeDependencies();
    print("didChangeDependencies ===========================");
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: system_back_function,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor:
                  isLoading ? Colors.black.withOpacity(.3) : Colors.white,
              leadingWidth: 1,
              title: GestureDetector(
                onTap: () {
                  if (!isLoading) print("object");
                  //
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      userName.length > 22
                          ? userName.substring(1, 20) + "..."
                          : userName,
                      style: TextStyle(
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
              actions: [
                SvgPicture.asset("assets/images/SVGs/noun-new-1886678.svg",
                    height: 26, width: 26),
                SizedBox(width: 15),
                GestureDetector(
                  onTap: () {
                    if (!isLoading)
                      ProfileMenuSheet.show(context, widget.settting_control);
                  },
                  child: SvgPicture.asset('assets/images/SVGs/new_menu.svg',
                      height: 35, width: 35),
                ),
                SizedBox(width: 10),
              ],
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    width: size.width,
                    decoration: BoxDecoration(
                        border: Border.symmetric(
                            horizontal:
                                BorderSide(color: Colors.grey, width: .5))),
                    child: Column(
                      children: [
                        // user post, followers, following
                        UserView.User_post_follow_following(
                            user_image,
                            name,
                            bio,
                            my_all_posts.length.toString(),
                            followers.length.toString(),
                            following.length.toString(),
                            () {}, () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (co) => My_Follow_page(
                                      followers: followers,
                                      following: following)));
                        }, () {}),
                        SizedBox(height: 10),
                        // Edit profile button
                        UserView.Edit_profile(() async {
                          // ignore: unused_local_variable
                          var info = await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => EditeProfilePage(cam: cam)));
                          if (info != null) {
                            _runData();
                          }
                          setState(() {});
                        }, () {
                          setState(() {});
                        }),
                        // discover people panel
                        AnimatedContainer(
                            duration: Duration(milliseconds: 800),
                            child: UserView.isSelect
                                ? Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Discover people",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w800)),
                                            Text("See All",
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w800)),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: size.width,
                                        height: size.height * .30,
                                        child: ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (con, i) => Row(
                                                  children: [
                                                    i == 0
                                                        ? SizedBox(width: 15)
                                                        : SizedBox.shrink(),
                                                    DiscoverPeople.build(
                                                        Size(size.width * .38,
                                                            size.height * .30),
                                                        null,
                                                        "rRahimjon Mirkmkm",
                                                        [
                                                          "Nuriddin Jorayev15 Nuriddin Jorayev"
                                                        ],
                                                        follow_button_isSelected[
                                                            i], () {
                                                      setState(() {
                                                        follow_button_isSelected[
                                                                i] =
                                                            follow_button_isSelected[
                                                                    i]
                                                                ? false
                                                                : true;
                                                      });
                                                    }),
                                                    i ==
                                                            follow_button_isSelected
                                                                    .length -
                                                                1
                                                        ? SizedBox(width: 15)
                                                        : SizedBox.shrink(),
                                                  ],
                                                ),
                                            separatorBuilder: (con, i) =>
                                                SizedBox(width: 10),
                                            itemCount: follow_button_isSelected
                                                .length),
                                      ),
                                    ],
                                  )
                                : SizedBox.shrink()),
                        SizedBox(height: 15),
                        _menu_list(),
                        SizedBox(height: 15),
                        // tab bar panel
                        Container(
                          width: size.width,
                          child: TabBar(
                              onTap: (i) {
                                print(i);
                                setState(() {
                                  tabBar_select_index = i;
                                });
                              },
                              indicatorColor: Colors.black,
                              tabs: [
                                Tab(
                                  icon: Icon(Icons.grid_on_outlined,
                                      color: tabBar_select_index != 0
                                          ? Colors.grey
                                          : Colors.black),
                                ),
                                Tab(
                                  icon: Icon(Feather.play,
                                      color: tabBar_select_index != 1
                                          ? Colors.grey
                                          : Colors.black),
                                ),
                                Tab(
                                  icon: Icon(Icons.person_pin_outlined,
                                      color: tabBar_select_index != 2
                                          ? Colors.grey
                                          : Colors.black),
                                ),
                              ]),
                        ),
                        // grid view panel with tab bar
                        Container(
                          height: size.height / 2,
                          width: size.width,
                          child: TabBarView(children: [
                            _grid_builder(size),
                            Text("data2"),
                            Text("data3"),
                          ]),
                        )
                      ],
                    ),
                  ),
                ),
                isLoading
                    ? Container(
                        height: size.height,
                        width: size.width,
                        color: Colors.black.withOpacity(.3),
                        child: MyLoadingWidget(progres_text: "Loading..."),
                      )
                    : SizedBox.shrink()
              ],
            )),
      ),
    );
  }

  List temp_list = [1, 2, 3, 4, 5];
  // Story HighLights panel
  Widget _menu_list() => AnimatedContainer(
        duration: Duration(milliseconds: 800),
        width: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //first
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Story HighLights",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                  ),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          panelIsOpen = panelIsOpen ? false : true;
                        });
                      },
                      child: Icon(
                        panelIsOpen
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        color: Colors.black,
                      ))
                ],
              ),
            ),

            panelIsOpen
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "Keep your favourite stories on your profile",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          width: MediaQuery.of(context).size.width + 8,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          margin: EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: temp_list
                                  .map((e) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                              height: e == 1 ? 55 : 45,
                                              width: e == 1 ? 55 : 45,
                                              margin: EdgeInsets.only(
                                                  top: e != 1 ? 5 : 0),
                                              decoration: BoxDecoration(
                                                  border: e == 1
                                                      ? Border.all(
                                                          color: Colors.black,
                                                          width: 1.5)
                                                      : Border(),
                                                  color: e == 1
                                                      ? Colors.white
                                                      : Colors.grey,
                                                  shape: BoxShape.circle),
                                              child: e == 1
                                                  ? Icon(
                                                      Icons.add,
                                                      color: Colors.black,
                                                      size: 35,
                                                    )
                                                  : SizedBox.shrink()),
                                          e == 1
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10),
                                                  child: Text("New"),
                                                )
                                              : SizedBox.shrink()
                                        ],
                                      ))
                                  .toList()),
                        ),
                      ),
                    ],
                  )
                : SizedBox.shrink()
          ],
        ),
      );

  // ignore: unused_element
  Widget _grid_builder(Size size) {
    return FutureBuilder<List<Post>>(
      future: DataService.get_posts(myuserId),
      builder: (BuildContext context, snap) {
        if (snap.connectionState == ConnectionState.done && snap.hasData) {
          return snap.data!.isNotEmpty
              ? GridView.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                  padding: EdgeInsets.only(top: 2),
                  children: snap.data!
                      .map((e) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => MypostsViewPage()))
                                  .then((value) {
                                setState(() {});
                              });
                            },
                            child: _items_of_grid(e.post_images),
                          ))
                      .toList(),
                )
              : Center(child: Text("No Posts"));
        } else if (snap.connectionState == ConnectionState.waiting) {
          return Container(
            height: 50,
            width: 50,
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              color: Colors.black,
              strokeWidth: 2,
            ),
          );
        }

        return Center(child: Text("No Posts"));
      },
    );
  }

  // items of grid
  Widget _items_of_grid(List url) =>
      url.isNotEmpty && !url.first.toString().contains(".mp4")
          ? CachedNetworkImage(
              height: 100,
              filterQuality: FilterQuality.low,
              fit: BoxFit.fill,
              placeholder: (con, i) => Container(
                    color: Colors.grey[200],
                    child: Text(""),
                  ),
              imageUrl: url[0])
          : url.first.toString().contains(".mp4")
              ? video_th(url.first)
              : Container();

  Widget video_th(url) {
    print(url);
    return FutureBuilder<Uint8List?>(
      future: VideoThumbnail.thumbnailData(video: url),
      builder: (con, snp) {
        if (snp.hasData) {
          return Image.memory(snp.data!, fit: BoxFit.cover);
        }
        return Container(
          decoration:
              BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
          child: AnimatedShimmer(
            height: 10,
            width: 120,
          ),
        );
      },
    );
  }

  Widget svg_viewer(String url) =>
      SvgPicture.asset(url, height: 20, width: 20, color: Colors.black);
}
