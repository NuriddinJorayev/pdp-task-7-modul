import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';

class DiscoverPeople {
  static bool select = false;

  static Widget build(Size size, img_url, String name, List followdBy,
      bool isfollowd, Function() follow_button) {
    if (followdBy.toString().length > 13) {
      List followd = followdBy;
      followd = followd.join("").split("");
      followd.insert(15, ' ');
      followdBy = followd;
    }
    if (name.length > 13) {
      if (name[13].compareTo(" ") != 0) {
        List l = name.split('');
        l.insert(13, " ");
        name = l.join("");
      }
    }
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 0.5),
          borderRadius: BorderRadius.circular(3)),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _delete_button()
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 15),
              // image
              Container(
                alignment: Alignment.center,
                width: size.width,
                child: _circle_avatar(img_url),
              ),
              // name
              SizedBox(height: 15),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(name,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          letterSpacing: .7),
                      overflow: TextOverflow.ellipsis,
                      softWrap: false)),
              // "Followed by" text
              SizedBox(height: 4),
              Text(followdBy.isNotEmpty ? "Followed by" : "Follows you",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      letterSpacing: .7)),
              // followed by
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(followdBy.join(''),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        letterSpacing: .7),
                    overflow: TextOverflow.ellipsis,
                    softWrap: false),
              ),
              SizedBox(height: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [_follow_buttton(isfollowd, follow_button)],
              )
            ],
          )
        ],
      ),
    );
  }

  static Widget _delete_button()=> Padding(
    padding: const EdgeInsets.all(4.0),
    child: GestureDetector(onTap: (){}, child: Icon(Feather.x, color: Colors.grey[800], size: 20,)),
  );

  // image builder
  static Widget _circle_avatar(img_url) => Container(
      height: 80,
      width: 80,
      alignment: Alignment.center,
      decoration: img_url != null
          ? BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: NetworkImage(img_url)))
          : BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
      child: img_url == null ? Icon(Entypo.user) : SizedBox.shrink());

  // follow button
  static Widget _follow_buttton(select, Function() press) => GestureDetector(
        onTap: press,
        child: Container(
            height: 25,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: !select
                ? MaterialButton(
                    color: Color.fromARGB(255, 3, 150, 247),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3)),
                    onPressed: press,
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Text("Follow",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                    ))
                : OutlinedButton(
                    onPressed: press,
                    child: Text("Following",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600)))),
      );
}
