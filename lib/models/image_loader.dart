import 'dart:io';

class MyImage_Video_taker {
  static List<List<String>> all_file_list = [];

  static List<String> images = [];
  static List<String> videos = [];

  static List<String> imnage_format = [
    ".bmp",
    '.jpg',
    '.jpeg',
    '.png',
    '.gif',
  ];
  static List<String> video_format = [
    '.mov',
    '.swf',
    '.mp4',
    '.mkv',
    '.avi',
    '.3pg',
    '.mpeg'
  ];

  static List<List<String>> RunAndLoad() {
    Directory f = Directory("/storage/emulated/0/");
    search(f, imnage_format, video_format);        
    all_file_list.addAll({images, videos});   
    return all_file_list;
    
  }

  static search(Directory d, List<String> im, List<String> vi){
    
    for (var e in d.listSync()) {
      if (FileSystemEntity.isFileSync(e.path)) {
        if (img_end_With(e.path, im)) {
          if (!images.contains(e.path)) {
            images.add(e.path);
          }
        } else if (vid_end_With(e.path, vi)) {
          if (!videos.contains(e.path)) {
            videos.add(e.path);
          }
        }
        
      } else if (FileSystemEntity.isDirectorySync(e.path)) {
        if (!e.path.endsWith("Android") && isNotHiddenFolder(e.path)) {
          search(Directory(e.path + "/"), imnage_format, video_format);
        }
      } else {
      }
    }
    return;
  }
  // this is a filter function example

  static bool isNotHiddenFolder(String s){
    var b = RegExp(r"^(?!.*(\/\.)).*$").hasMatch(s);
    return b;
  }

  static bool img_end_With(String s, List<String> img) {
    for (var e in img) {
      if (s.toLowerCase().endsWith(e.toLowerCase())) {
        return true;
      }
    }
    return false;
  }

  static bool vid_end_With(String s, List<String> vid) {
    for (var e in vid) {
      if (s.toLowerCase().endsWith(e.toLowerCase())) {
        return true;
      }
    }
    return false;
  }
}
