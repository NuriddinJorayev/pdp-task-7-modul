import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_myinsta/functions/image_sizeer.dart';
import 'package:flutter_myinsta/services/share_prefs.dart';

class FileService {
  static Future<String> SetImage(File imageFile,
      {String key = "Myuser"}) async {
    if (!imageFile.path.endsWith('.mp4')) {
      imageFile = await ImageSizer.setAndGet_file_url(imageFile.path);
      print('code1');
    }
    print('code2');
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
            .child(await getRandomString())
            .putFile(imageFile);
    var taskSnapshot = (await upload.whenComplete(() => {}));
    var takeUrl = taskSnapshot.ref.getDownloadURL();
    print("rasm keldi 1");
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

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static Random _rnd = Random();

  static Future<String> getRandomString() async {
    var id = await Prefs.Load();
    String name = String.fromCharCodes(Iterable.generate(
        30, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    ListResult list_r = await FirebaseStorage.instance
        .ref()
        .child("all Posts images")
        .child(id)
        .listAll();

    if (list_r.items.contains(name)) {
      return getRandomString();
    }
    return name;
  }
}
