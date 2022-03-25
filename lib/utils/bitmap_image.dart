import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:image/image.dart'show decodeImage, encodeJpg;

class BitmapImage {
  static Widget bitmap(String s, int quality) {
    var img = decodeImage(File(s).readAsBytesSync());
   var bytes = encodeJpg(img!, quality: quality);
   var d = Uint8List.fromList(bytes);
   return Image.memory(d, fit: BoxFit.fill,);
  }
  
}