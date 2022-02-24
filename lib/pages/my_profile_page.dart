import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_myinsta/functions/page_control.dart';
import 'package:flutter_myinsta/models/myUser.dart';
import 'package:flutter_myinsta/pages/profile_pages.dart/edite_profile_page.dart';
import 'package:flutter_myinsta/services/data_service.dart';
import 'package:flutter_myinsta/services/hive_db.dart';
import 'package:flutter_myinsta/services/share_prefs.dart';
import 'package:flutter_myinsta/widgets/loading_widget.dart';
import 'package:flutter_myinsta/widgets/profile_widgets/discover_people.dart';
import 'package:flutter_myinsta/widgets/profile_widgets/users_view.dart';
import 'package:flutter_myinsta/widgets/sheets/profile_menu.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  int followers = 0;
  int following = 0;
  bool isLoading = false;
  List posts = [];
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
  List tempImageList = [
    "https://cloudfront-us-east-2.images.arcpublishing.com/reuters/F6INOOMSRRL5XOOQDRPZUWPWBA.jpg",
    "https://api.contentstack.io/v2/assets/575e4d1c0342dfd738264a1f/download?uid=bltada7771f270d08f6",
    "https://cdn.wallpapersafari.com/37/79/W90lpP.jpg",
    "https://cdn.wallpapersafari.com/23/77/DP60WY.jpeg",
    "https://cdn.wallpapersafari.com/65/97/Jpx0cr.jpg",
  ];
  int tabBar_select_index = 0;
  bool user_view = true;

  @override
  void initState() {


        _runData();

    super.initState();
    initialize();
    initi_filds();
  }

  initi_filds() async{
    var id = await Prefs.Load();
    if (mounted) {
      setState(() {
        var user = MyUser.FromJson(Hive_db.load(id));
        user_image = user.user_image.isNotEmpty? user.user_image : user_image;
        userName = user.userName.isNotEmpty ? user.userName : userName;
        name = user.name.isNotEmpty ? user.name : name;
        bio = user.bio.isNotEmpty ? user.bio : bio;
        followers = user.followers != 0 ? user.followers : followers;
        following = user.following != 0 ? user.following : following;
        posts = user.posts.isNotEmpty ? user.posts : posts;
      });
    }
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
                            duration: Duration(milliseconds: 1),
                            curve: Curves.easeInOut);
                      }
                    });
    return false;
  }

  _runData() async {
    var id  = await Prefs.Load();
    setState(() => isLoading = true);
    var user_data = MyUser.FromJson((await DataService.getData()));
    var user = MyUser(    
        user_data.id,  
        user_data.user_image,
        user_data.name,
        user_data.userName,
        user_data.bio,
        user_data.posts,
        user_data.followers,
        user_data.following);
    Hive_db.set(id, user.Tojson());
    initi_filds();

    setState(() => isLoading = false);
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
              backgroundColor: isLoading? Colors.black.withOpacity(.3): Colors.white,
              leadingWidth: 1,
              title: GestureDetector(
                onTap: () {
                  if(!isLoading)
                  print("object");
                  //
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(color: Colors.black),
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
                     if(!isLoading)
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
                                BorderSide(color: Colors.black, width: .5))),
                    child: Column(
                      children: [
                        // user post, followers, following
                        UserView.User_post_follow_following(
                            user_image,
                            name,
                            bio,
                            posts.length.toString(),
                            followers.toString(),
                            followers.toString()),
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
                                        height: size.height * .28,
                                        child: ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (con, i) => Row(
                                                  children: [
                                                    i == 0
                                                        ? SizedBox(width: 15)
                                                        : SizedBox.shrink(),
                                                    DiscoverPeople.build(
                                                        Size(size.width * .38,
                                                            size.height * .28),
                                                        null,
                                                        "Rahimjon Mirkmkm",
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
                            _grid_builder(tempImageList),
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
  Widget _grid_builder(List l) {
    return GridView.count(
      crossAxisCount: 4,
      mainAxisSpacing: 1,
      crossAxisSpacing: 1,
      children: l.map((e) => _items_of_grid(e)).toList(),
    );
  }

  // items of grid
  Widget _items_of_grid(url) => CachedNetworkImage(
      height: 100,
      filterQuality: FilterQuality.low,
      fit: BoxFit.fill,
      placeholder: (con, i) => Container(
            color: Colors.grey[200],
            child: Text(""),
          ),
      imageUrl: url);

  Widget svg_viewer(String url) =>
      SvgPicture.asset(url, height: 20, width: 20, color: Colors.black);
}
