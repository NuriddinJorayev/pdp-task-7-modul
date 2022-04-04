import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';

class UserView {
  static Widget User_post_follow_following(
          String img_url,
          String name,
          String subtitle,
          String post,
          String follow,
          String following,
          b(),
          bb(),
          bbb()) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.grey, shape: BoxShape.circle),
                      height: 100,
                      width: 100,
                      // currently fileimage is used later networkimage is used
                      // ignore: unnecessary_null_comparison
                      child: img_url != null
                          ? img_url.isNotEmpty
                              ? Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              img_url),
                                          fit: BoxFit.cover),
                                      shape: BoxShape.circle),
                                )
                              : Icon(Feather.user)
                          : Icon(Feather.user)),
                ),
                Expanded(
                  child: InkWell(onTap: b, child: _text_builder(post, "Posts")),
                ),
                Expanded(
                  child: InkWell(
                      onTap: bb, child: _text_builder(follow, "Followers")),
                ),
                Expanded(
                  child: InkWell(
                      onTap: bbb, child: _text_builder(following, "Following")),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      letterSpacing: .5),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                ),
              ],
            )
          ],
        ),
      );

  static Widget _text_builder(String text1, String text2) => Container(
        height: 90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              text1,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              text2,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      );

  static Color contaoin_color = Colors.white;
  static bool isSelect = true;

  static Widget Edit_profile(Function() press1, Function() press2) {
    contaoin_color = Colors.white;
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: press1,
              child: Container(
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: contaoin_color,
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(3)),
                child: Text(
                  "Edit profile",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      letterSpacing: .8),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.0),
          GestureDetector(
            onTap: () {
              if (isSelect) {
                isSelect = false;
                press2();
              } else {
                isSelect = true;
                press2();
              }
            },
            child: Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: isSelect ? Colors.grey[300] : Colors.white,
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(3)),
              child: Icon(
                isSelect ? FlutterIcons.person_add_mdi : Feather.user_plus,
                color: Colors.black,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
