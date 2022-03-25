import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

class isImage {
  static String isImg(Uint8List bytes) {
    String s;
    // ignore: unnecessary_null_comparison
    if (bytes == null) {
      return "";
    }
    try {
      // ignore: unused_local_variable
      var wid = MemoryImage(bytes);
      s = "i";
    } catch (e) {
      s = "v";
    }
    return s;
  }
}
