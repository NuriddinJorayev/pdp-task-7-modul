import 'package:flutter/material.dart';

class Effect_list {
  
  static List ListColorFilter = [
    ColorFilter.mode(Colors.white, BlendMode.dst),
    ColorFilter.mode(Colors.blue[900]!, BlendMode.color),
     ColorFilter.mode(Colors.deepOrangeAccent[200]!.withOpacity(.4), BlendMode.color),
     ColorFilter.mode(Colors.grey, BlendMode.color),
      ColorFilter.mode(Colors.blueGrey, BlendMode.color),
       ColorFilter.mode(Colors.orange[200]!.withOpacity(.4), BlendMode.color),
        ColorFilter.mode(Colors.white60, BlendMode.color), // 7
         ColorFilter.mode(Colors.deepOrange[200]!.withOpacity(0.7), BlendMode.color),
         ColorFilter.mode(Colors.black.withOpacity(.4), BlendMode.color),
         ColorFilter.mode(Colors.white.withOpacity(0.5), BlendMode.overlay),
         ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.srcATop), //aden
         ColorFilter.mode(Colors.white.withOpacity(0.3), BlendMode.srcATop),
         ColorFilter.mode(Colors.green.withOpacity(.6), BlendMode.overlay), //amaro
         ColorFilter.mode(Colors.redAccent.withOpacity(.6), BlendMode.color),
         ColorFilter.mode(Colors.white.withOpacity(.5), BlendMode.overlay), //rise
          ColorFilter.mode(Colors.limeAccent.withOpacity(.9), BlendMode.overlay),
           ColorFilter.mode(Colors.yellow.withOpacity(.7),  BlendMode.overlay),
           ColorFilter.mode(Colors.brown.withOpacity(0.9),  BlendMode.overlay),// sierra
           ColorFilter.mode(Colors.brown[100]!.withOpacity(0.5),  BlendMode.overlay),
           ColorFilter.mode(Colors.white.withOpacity(0.7),  BlendMode.overlay), // lo-fi
           ColorFilter.mode(Colors.grey.withOpacity(.7),  BlendMode.hue),

    ];

  
}