import 'dart:io';

import 'package:flutter/material.dart';

class Gallery_Image_builder {

  static Widget build(BuildContext context, String img_url, bool select_able, Function(String url) url_func, bool isticked, String n, Function() press, Function() ontap, [h]) => GestureDetector(
    onLongPress: press,
    onTap:(){
      select_able? ontap() : (){};
      url_func(img_url);
    },
    child: Container(
      height:  h?? 100,
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: FileImage(File(img_url)),
          fit: BoxFit.cover
        )
      ),
      alignment: Alignment.topRight,
      child: select_able? roundBuilder(context, n, isticked,  ontap) : SizedBox.shrink(),
    ),
  );

 static Widget roundBuilder(BuildContext context, String value, bool isselect, Function() ontap) => GestureDetector(
   onTap:  ontap,
   child: Container(
     height: 20,
     width: 20,
     alignment: Alignment.center,
     decoration: BoxDecoration(
       border: Border.all(
         color: Colors.white,
         width: 1
       ),
       shape: BoxShape.circle,
       color: isselect? Colors.blue : Colors.grey.withOpacity(.3),
     ),
     child: isselect? Text(value, style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold)) : SizedBox.shrink()
   ),
 );

  
}