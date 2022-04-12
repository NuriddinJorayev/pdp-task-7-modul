import 'dart:math';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class Image_downloader {
  Future<List<File>> Download(List images_url) async {
    List<File> list = [];
    for (var e in images_url) {
      var response = await http.get(Uri.parse(e));
      Directory tempDirectory = await getTemporaryDirectory();
      File file = new File(tempDirectory.path + "/" + '${random_name(20)}.png');
      file.writeAsBytesSync(response.bodyBytes);
      list.add(file);
    }
    return list;
  }

  String random_name(int length) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    String s = String.fromCharCodes(Iterable<int>.generate(
        length, (i) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    return s;
  }
}
