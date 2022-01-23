import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Camera_left_button {
  static bool isOpen = true;
  static Widget build(Size allSize, icon, String text) => AnimatedContainer(
    duration: Duration(milliseconds: 500),
        height: allSize.height,
        width: allSize.width,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(20.0),
        child: Row(
          children: [
            icon is String? 
        SvgPicture.asset(icon, height: 21, width: 21) :
        Icon(icon, color: Colors.white),
        SizedBox(width: 10.0),
        isOpen? Text(text, style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800)) : 
        SizedBox.shrink()
          ],
        )
      );
}
