import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';

class User_Widgets {
  static Widget itemOfUser(username, name, String img_url,
      [bool isOutline = false]) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          circle_image(img_url, isOutline),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(username,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                Text(name,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w400)),
              ],
            ),
          ),
          Icon(
            Feather.x,
            color: Colors.black,
            size: 12,
          )
        ],
      ),
    );
  }

  static Widget circle_image(String img_url, [bool isOutline = false]) =>
      Column(
        children: [
          Container(
            height: 60,
            width: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                gradient: isOutline
                    ? LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                            Color.fromARGB(255, 255, 250, 6),
                            Color.fromARGB(250, 223, 3, 139)
                          ])
                    : null),
            child: Container(
              margin: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.white, width: 1),
                  image: img_url.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(img_url), fit: BoxFit.fill)
                      : DecorationImage(
                          image: AssetImage("assets/images/default_user.png"),
                          fit: BoxFit.fill)),
            ),
          ),
        ],
      );
}
