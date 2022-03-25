

import 'dart:io';


import 'package:image/image.dart';
import 'package:path_provider/path_provider.dart';

class ImageSizer {
  
  static Future<File>  setAndGet_file_url(String s)async{
   var img = decodeImage(File(s).readAsBytesSync());
   var bytes = encodeJpg(img!, quality: 10);
   File f = File((await getTemporaryDirectory()).path + "img.png");
   f.createSync();
   f.writeAsBytesSync(bytes);
   return f;
  }
 
  //  image size = 10108854 = 9.640 mb 
  // changed
  // image copyed = 2249461  = 2.145 mb


  
}