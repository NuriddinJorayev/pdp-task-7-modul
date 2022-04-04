import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myinsta/models/like_time.dart';
import 'package:flutter_myinsta/models/myUser.dart';
import 'package:flutter_myinsta/models/post.dart';
import 'package:flutter_myinsta/services/data_service.dart';
import 'package:flutter_myinsta/services/share_prefs.dart';
import 'package:flutter_myinsta/utils/date_time_parse.dart';

class MyLikesPage extends StatefulWidget {
  const MyLikesPage({Key? key}) : super(key: key);

  @override
  State<MyLikesPage> createState() => _MyLikesPageState();
}

class _MyLikesPageState extends State<MyLikesPage> {
  String posted_time = "";
  List<LikeTime> likedby = [];

  @override
  void initState() {
    super.initState();
    filds_initialize();
    print('like  = ${likedby.length}');
  }

  filds_initialize() async {
    List<Post> posts = [];
    var id = await Prefs.Load();
    await FirebaseFirestore.instance
        .collection("all Users Posts")
        .get()
        .then((value) async {
      final v = await value.docs.toList();
      for (var item in v) {
        var p = Post.fromjson(item.data());
        if (id == p.userId) {
          posts.add(p);
          print("I found 1 liked ");
        }
      }
    });
    print(posts.length);

    setState(() {
      for (var e in posts) {
        likedby.addAll(e.likes);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          "Activity",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        height: h,
        width: w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            time_checker("Today")
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                    child: Text("Today",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  )
                : SizedBox.shrink(),
            ...items_builder(likedby, "Today"),
            /////////////////////////
            time_checker("Yestoday")
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                    child: Text("Yestoday",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  )
                : SizedBox.shrink(),
            ...items_builder(likedby, "Yestoday"),
            /////////////////////////
            time_checker("This Week")
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                    child: Text("This Week",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  )
                : SizedBox.shrink(),
            ...items_builder(likedby, "This Week"),
            /////////////////////////
            time_checker("This Month")
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                    child: Text("This Month",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  )
                : SizedBox.shrink(),
            ...items_builder(likedby, "This Month"),
          ],
        ),
      ),
    );
  }

  bool time_checker(String s) {
    for (var e in likedby) {
      if (DateTimeParse(e.time).get_time_ago(true) == s) {
        return true;
      }
    }
    return false;
  }

  Widget Circle_avatar(String url) => Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 45,
        width: 45,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22.5),
          child: CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.fill,
          ),
        ),
      );

  List<Widget> items_builder(List<LikeTime> like, String how) {
    List<Widget> l = [];
    for (var e in like) {
      if (DateTimeParse(e.time).get_time_ago(true) == how) {
        l.add(Items(
            e.myuser.user_image, e.myuser.userName, e.time, e.post_images));
      }
    }
    return l;
  }

  Widget Items(
      String url, String likedby, String time, List<dynamic> post_img) {
    print("post_img = " + post_img[0]);

    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Circle_avatar(url),
          SizedBox(width: 10),
          Expanded(
              child: text_builder(likedby, videoORphoto(post_img[0]), time)),
          SizedBox(width: 5),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 45,
            width: 45,
            child: CachedNetworkImage(
              imageUrl: post_img.first,
              fit: BoxFit.fill,
            ),
          )
        ],
      ),
    );
  }

  String videoORphoto(String s) {
    if (s.contains("mp4"))
      return "Video";
    else
      return "photo";
  }

  text_builder(String username, String video_or_photo, String time) {
    return RichText(
      maxLines: 3,
      text: TextSpan(
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
          children: [
            TextSpan(
              text: username,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            TextSpan(text: " liked "),
            TextSpan(text: "your "),
            TextSpan(text: video_or_photo + '.'),
            TextSpan(
                text: ' ' + DateTimeParse(time).get_time_ago(),
                style: TextStyle(color: Colors.grey[700])),
          ]),
    );
  }
}
