import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_myinsta/functions/image_sizeer.dart';
import 'package:flutter_myinsta/services/share_prefs.dart';

class FileService {
  static Future<String> SetImage(File imageFile,
      {String key = "Myuser"}) async {
    if (!imageFile.path.endsWith('.mp4')) {
      if (imageFile.readAsBytesSync().lengthInBytes > 5242880) {
        var small_file = ImageSizer.setAndGet_file_url(imageFile.path);
        imageFile = await small_file;
      }
    }
    String image_name = await Prefs.Load();
    var upload = key == "Myuser"
        ? FirebaseStorage.instance
            .ref()
            .child(key)
            .child(image_name)
            .putFile(imageFile)
        : FirebaseStorage.instance
            .ref()
            .child(key)
            .child(image_name)
            .child(imageFile.path)
            .putFile(imageFile);
    var taskSnapshot = (await upload.whenComplete(() => {}));
    var takeUrl = taskSnapshot.ref.getDownloadURL();
    return takeUrl;
  }

  static Future<String> getImage({String key = "Myuser"}) async {
    var upload = FirebaseStorage.instance.ref().child(key).listAll();
    var taskSnapshot = await upload;
    var list = (await taskSnapshot);
    list.items.forEach((element) {
      print('my img url = ${element}');
    });
    var url =
        list.items.length == 0 ? "" : (await list.items.first.getDownloadURL());
    return url;
  }

  static Future<void> DeleteImage() async {
    FirebaseStorage.instance.ref().delete();
  }
}
