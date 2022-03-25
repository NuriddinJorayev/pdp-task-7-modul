import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_myinsta/models/myUser.dart';
import 'package:flutter_myinsta/models/post.dart';
import 'package:flutter_myinsta/pages/video_opener.dart';
import 'package:flutter_myinsta/services/data_service.dart';
import 'package:flutter_myinsta/services/share_prefs.dart';
import 'package:flutter_myinsta/widgets/feed_user_panel.dart';
import 'package:flutter_myinsta/widgets/my_rich_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_like_button/insta_like_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:visibility_detector/visibility_detector.dart';

class MyFeedPage extends StatefulWidget {
  const MyFeedPage({Key? key}) : super(key: key);

  @override
  State<MyFeedPage> createState() => _MyFeedPageState();
}

class _MyFeedPageState extends State<MyFeedPage> {
  Size? mediaquery_size;
  var main_page_control = ScrollController();

  String img1 =
      "https://www.perma-horti.com/wp-content/uploads/2019/02/image-2.jpg";
  String img2 = "https://ychef.files.bbci.co.uk/976x549/p0738j5f.jpg";

  List<Post> All_posts = [];
  var MyUserid;

  @override
  void initState() {
    up_load();
    getMyId();
    super.initState();
    print(All_posts.length);
    main_page_control.addListener(() {
      setState(() {});
    });
  }

  up_load() async {
    var map = await await DataService.getData("all Users Posts");
    setState(() {
      for (var e in map["allPosts"]) {
        print(Post.fromjson(e).user_name);
        All_posts.add(Post.fromjson(e));
      }
      //  All_posts = List<Post>.from(map["allPosts"].map((e)=> Post.fromjson(e)));
    });
    print(All_posts.length);
  }

  @override
  Widget build(BuildContext context) {
    var allsize = MediaQuery.of(context).size;
    mediaquery_size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leadingWidth: 0,
          title: Row(
            children: [
              Text("Home", style: TextStyle(color: Colors.black, fontSize: 30)),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.black,
              )
            ],
          ),
          actions: [
            GestureDetector(
              onTap: () async {
                // DataService.SetNewData();
                print("cloud data");
                // DataService.Updata("Nurik nima gaplar yana o'zingda");
                // QuerySnapshot<Map<String, dynamic>> query = await DataService.getData();
                // print(query.docs.first.data());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                    "assets/images/SVGs/icons8-facebook-messenger(1).svg",
                    height: 30,
                    width: 30),
              ),
            ),
          ],
        ),
        body: Container(
          height: allsize.height,
          width: allsize.width,
          child: ListView.builder(
              controller: main_page_control,
              itemCount: All_posts.length,
              itemBuilder: (BuildContext con, int index) {
                // ignore: unnecessary_null_comparison
                if (All_posts[index].post_images != null) {
                  return post_items_builder(All_posts[index]);
                }
                return SizedBox.shrink();
              }),
        ));
  }

// post items builder function

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
                                if (item.id == id) {
                                  isliked = true;
                                }
                              }
                              setState(() {
                                if (!isliked) {
                                  p.likes.add(myuser);
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
                                      print("aaaaaaaa");
                                      var myuser = MyUser.FromJson(
                                          await DataService.getData());
                                      var id = await Prefs.Load();
                                      bool isliked = false;
                                      for (var item in p.likes) {
                                        if (item.id == id) {
                                          isliked = true;
                                        }
                                      }
                                      setState(() {
                                        if (!isliked) {
                                          p.likes.add(myuser);
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
                              if (item.id == id) {
                                isliked = true;
                              }
                            }

                            setState(() {
                              if (!isliked) {
                                p.likes.add(myuser);
                              } else {
                                int i = -1;
                                for (var item in p.likes) {
                                  i++;
                                  if (item.id == id) {
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

  getMyId() async {
    MyUserid = await Prefs.Load().then((value) => value);
  }

  bool isLiked_Or_DisLiked(List<MyUser> user, id) {
    for (var u in user) {
      if (id == u.id) {
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

class Video_wid extends StatefulWidget {
  final String url;
  final Post p;
  Video_wid({Key? key, required this.url, required this.p}) : super(key: key);

  @override
  _Video_widState createState() => _Video_widState();
}

class _Video_widState extends State<Video_wid> {
  VideoPlayerController? main_con;
  bool isBuffering = false;
  bool isInitialized = false;
  bool isNoice = false;

  @override
  void initState() {
    super.initState();
    main_con = VideoPlayerController.network(
      widget.url,
    )..initialize();
    main_con!.play();

    main_con?.setLooping(true);
    main_con?.addListener(() {
      setState(() {
        isBuffering = main_con!.value.isBuffering;
        isInitialized = main_con!.value.isInitialized;
      });
    });
  }

  @override
  void dispose() {
    main_con!.dispose();
    main_con = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("mykey"),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => Feed_Video(
                      likes: widget.p.likes.length.toString(),
                      comments: widget.p.comments,
                      user_image: widget.p.user_image,
                      appbar_title: "Reels",
                      user_name: widget.p.user_name,
                      video_url: widget.url,
                      caption: widget.p.caption)));
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            !isBuffering && isInitialized
                ? VideoPlayer(main_con!)
                : FutureBuilder<Uint8List?>(
                    future: VideoThumbnail.thumbnailData(video: widget.url),
                    builder: (con, snp) {
                      if (snp.hasData) {
                        return Image.memory(snp.data!);
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
            Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: Volume_con,
                child: Container(
                  height: 30,
                  width: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.black.withOpacity(.5),
                        Colors.black.withOpacity(.5),
                      ]),
                      shape: BoxShape.circle),
                  child: Icon(
                    isNoice ? Icons.volume_up : Icons.volume_off,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.topRight,
              padding: EdgeInsets.all(15),
              child: Image.asset(
                "assets/images/reels.png",
                height: 26,
                width: 26,
                fit: BoxFit.fill,
              ),
            )
          ],
        ),
      ),
      onVisibilityChanged: (info) {
        if (main_con != null) {
          if (info.visibleFraction > .5) {
            main_con!.play();
          } else {
            main_con!.pause();
          }
        }
      },
    );
  }

  Volume_con() {
    setState(() {
      isNoice = !isNoice;
    });
    main_con!.setVolume(isNoice ? 1 : 0);
  }
}

extension checkURLtoVideo on String {
  bool checkURL() {
    return this.toLowerCase().contains(".mp4");
  }
}
