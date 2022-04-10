// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_myinsta/models/like_time.dart';
import 'package:flutter_myinsta/models/myUser.dart';
import 'package:flutter_myinsta/models/post.dart';
import 'package:flutter_myinsta/pages/my_feed_page.dart';
import 'package:flutter_myinsta/services/data_service.dart';
import 'package:flutter_myinsta/services/share_prefs.dart';
import 'package:flutter_myinsta/widgets/dialog/post_remove_dialog.dart';
import 'package:flutter_myinsta/widgets/feed_user_panel.dart';
import 'package:flutter_myinsta/widgets/my_rich_text.dart';
import 'package:flutter_myinsta/widgets/sheets/gallry_button_sheet.dart';
import 'package:flutter_myinsta/widgets/sheets/other_user_more_sheet.dart';
import 'package:insta_like_button/insta_like_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widgets/loading_widget.dart';

class MypostsViewPage extends StatefulWidget {
  MypostsViewPage({Key? key}) : super(key: key);

  @override
  State<MypostsViewPage> createState() => _MypostsViewPageState();
}

class _MypostsViewPageState extends State<MypostsViewPage> {
  var main_page_control = ScrollController();
  bool isLoading = false;
  String MyUserid = '';
  @override
  void initState() {
    getMyId();
    super.initState();
    FirebaseFirestore.instance
        .collection("all Users Posts")
        .snapshots()
        .listen((event) {
      print("Listener is run -----------------------------------");
      if (mounted) {
        setState(() {});
      }
    });
  }

  Future<bool> willpopscope() async {
    Navigator.pop(context);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var allsize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: willpopscope,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  AntDesign.arrowleft,
                  color: Colors.black,
                  size: 30,
                )),
            title: Text("Posts",
                style: TextStyle(color: Colors.black, fontSize: 22)),
          ),
          body: Stack(
            children: [
              Container(
                  height: allsize.height,
                  width: allsize.width,
                  child: FutureBuilder<List<Post>>(
                    future: DataService.get_posts(MyUserid),
                    builder: (con, snp) {
                      if (snp.connectionState == ConnectionState.done &&
                          snp.hasData) {
                        return ListView.builder(
                            controller: main_page_control,
                            itemCount: snp.data!.length,
                            itemBuilder: (BuildContext con, int index) {
                              // ignore: unnecessary_null_comparison
                              if (snp.data![index].post_images != null) {
                                return post_items_builder(snp.data![index]);
                              }
                              return Center(
                                child: Text("No posts"),
                              );
                            });
                      } else if (snp.connectionState ==
                          ConnectionState.waiting) {
                        return Container(
                            height: allsize.height,
                            width: allsize.width,
                            color: Colors.black.withOpacity(.3),
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                                color: Colors.black, strokeWidth: 2));
                      }

                      return Center(child: Text("No posts"));
                    },
                  )),
              isLoading
                  ? Container(
                      height: allsize.height,
                      width: allsize.width,
                      color: Colors.black.withOpacity(.3),
                      alignment: Alignment.center,
                      child: MyLoadingWidget(progres_text: "Removing..."))
                  : SizedBox.shrink()
            ],
          )),
    );
  }

  double image_size = 300.0;
  var page_con = PageController();
  int image_avtive_index = 0;
// post items builder function
  Widget post_items_builder(Post p) => Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyFeedUserPanel(
              title: p.user_name,
              subtitle: p.location,
              user_image: p.user_image,
              more_button_tap: () {
                // OtherUserMoreSheet.Show(context, () => null);
                sheet_checker(p);
              },
            ),
            // base image
            p.post_images.length == 1
                ? p.post_images[0].toString().checkURL()
                    ? video_Builder(p.post_images[0], p)
                    : CachedNetworkImage(
                        width: MediaQuery.of(context).size.width,
                        imageUrl: p.post_images[0],
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            Center(child: Icon(Icons.error)),
                        imageBuilder: (con, _image_provider) => InstaLikeButton(
                            width: MediaQuery.of(context).size.width,
                            image: _image_provider,
                            imageBoxfit: BoxFit.cover,
                            iconSize: 100,
                            onChanged: () async {
                              var myuser =
                                  MyUser.FromJson(await DataService.getData());
                              var id = await Prefs.Load();
                              bool isliked = false;
                              for (var item in p.likes) {
                                if (item.myuser.id == id) {
                                  isliked = true;
                                }
                              }
                              setState(() {
                                if (!isliked) {
                                  LikeTime like_time = LikeTime(
                                      GetNowTime(), p.post_images, myuser);
                                  p.likes.add(like_time);
                                }
                              });
                              print(p.userId);
                              DataService.Updata_post(p.ToJson());
                            }))
                : Container(
                    width: MediaQuery.of(context).size.width,
                    height: image_size,
                    child: PageView.builder(
                      controller: page_con,
                      onPageChanged: (int i) {
                        setState(() {
                          image_avtive_index = i;
                        });
                      },
                      itemCount: p.post_images.length,
                      itemBuilder: (con, int index) {
                        return CachedNetworkImage(
                            width: MediaQuery.of(context).size.width,
                            imageUrl: p.post_images[index],
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Center(child: Icon(Icons.error)),
                            imageBuilder: (con, _image_provider) =>
                                InstaLikeButton(
                                    width: MediaQuery.of(context).size.width,
                                    image: _image_provider,
                                    imageBoxfit: BoxFit.cover,
                                    iconSize: 100,
                                    onChanged: () async {
                                      var myuser = MyUser.FromJson(
                                          await DataService.getData());
                                      var id = await Prefs.Load();
                                      bool isliked = false;
                                      for (var item in p.likes) {
                                        if (item.myuser.id == id) {
                                          isliked = true;
                                        }
                                      }
                                      setState(() {
                                        if (!isliked) {
                                          LikeTime like_time = LikeTime(
                                              GetNowTime(),
                                              p.post_images,
                                              myuser);
                                          p.likes.add(like_time);
                                        }
                                      });
                                      print(p.userId);
                                      DataService.Updata_post(p.ToJson());
                                    }));
                      },
                    ),
                  ),
            SizedBox(height: 5.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        // like button
                        InkResponse(
                          onTap: () async {
                            var myuser =
                                MyUser.FromJson(await DataService.getData());
                            var id = await Prefs.Load();
                            bool isliked = false;
                            for (var item in p.likes) {
                              if (item.myuser.id == id) {
                                isliked = true;
                              }
                            }

                            setState(() {
                              if (!isliked) {
                                LikeTime like_time = LikeTime(
                                    GetNowTime(), p.post_images, myuser);
                                p.likes.add(like_time);
                              } else {
                                int i = -1;
                                for (var item in p.likes) {
                                  i++;
                                  if (item.myuser.id == id) {
                                    p.likes.removeAt(i);
                                    break;
                                  }
                                }
                              }
                            });

                            print(p.userId);
                            DataService.Updata_post(p.ToJson());
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            child: isLiked_Or_DisLiked(p.likes, MyUserid)
                                ? Icon(FontAwesome.heart,
                                    size: 23.0, color: Colors.red)
                                : Icon(Feather.heart, size: 23.0),
                          ),
                        ),

                        SizedBox(width: 15.0),

                        Image.asset(
                          "assets/images/bubble-chat(1).png",
                          height: 24,
                          width: 24,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 15.0),
                        Transform.rotate(
                          angle: 3.14 / 10,
                          child: Icon(Feather.send),
                        ),
                      ],
                    ),
                  ),
                  // image  indecator
                  p.post_images.length > 1
                      ? Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: AnimatedSmoothIndicator(
                              activeIndex: image_avtive_index,
                              count: p.post_images.length,
                              effect: ScrollingDotsEffect(
                                dotColor: Colors.grey[600]!,
                                activeDotColor: Colors.blue[600]!,
                                spacing: 5.0,
                                dotHeight: 6,
                                dotWidth: 6,
                                maxVisibleDots: 5,
                              ),
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                  Expanded(
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: Icon(FontAwesome.bookmark_o)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            // all likes view panel
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  p.likes.length != 0
                      ? Text(
                          "${p.likes.length} likes",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        )
                      : SizedBox.shrink(),
                  SizedBox(height: 5.0),
                  MyRichText(
                    text: (p.user_name + " " + p.caption),
                    userName: p.user_name,
                  )
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),

              // need a time Accountent class

              child: Text(p.time,
                  style: TextStyle(color: Colors.grey, fontSize: 14)),
            ),
            SizedBox(height: 15.0),
          ],
        ),
      );

  sheet_checker(Post p) async {
    var id = await Prefs.Load();
    if (p.userId == id) {
      GalleryButtonSheet.Show(context, [
        "Copy Link",
        "Share to...",
        "Delete",
        "Edit"
      ], [
        () {},
        () {},
        () async {
          setState(() => isLoading = true);
          print("object111");
          await PostRemoveDialog.show(context, p.post_images[0], () async {
            var del = await DataService.Delete_my_post(p);
            if (del) {
              List<Post> posts = await DataService.get_posts(id);
              if (posts != null) {
                print("list bosh bo'ldi ");
                if (posts.isEmpty) {
                  Navigator.pop(context);
                }
              }
            }
          });

          setState(() => isLoading = false);

          // await Future.delayed(Duration(seconds: 2));
        },
        () {}
      ]);
    } else {
      OtherUserMoreSheet.Show(context, () => null);
    }
  }

  getMyId() async {
    var v = await Prefs.Load().then((value) => value);
    setState(() {
      MyUserid = v;
    });
  }

  String GetNowTime() {
    String y = DateTime.now().year.toString();
    String m = DateTime.now().month.toString();
    String d = DateTime.now().day.toString();
    String h = DateTime.now().hour.toString();
    String min = DateTime.now().minute.toString();

    return "$y-$m-$d $h:$min";
  }

  bool isLiked_Or_DisLiked(List<LikeTime> user, id) {
    for (var u in user) {
      if (id == u.myuser.id) {
        return true;
      }
    }
    return false;
  }

  String lastURL = "";

  Widget video_Builder(String url, Post p) {
    return Container(
        height: 250,
        width: MediaQuery.of(context).size.width,
        child: Video_wid(url: url, p: p));
  }
}
