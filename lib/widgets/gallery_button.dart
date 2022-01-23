import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyGalleryButton {
  static bool iselect = false;

  static Widget build(icon, int index, Function() ontap) => GestureDetector(
    onTap: ontap,
    child: Container(
      height: 32,
      width: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: iselect && index == 0? Colors.blue[700] : Colors.black87.withOpacity(.6),
      ),
      child: icon is String == true ? 
      Transform.rotate(
        angle: 9.42,
        child: SvgPicture.asset(icon, color: Colors.white, height: 21, width: 21) 
      ):
      Icon(icon, color: Colors.white, size: 18),
    ),
  );  
}