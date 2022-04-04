import 'package:flutter_myinsta/models/myUser.dart';

class LikeTime {
  String time;
  List post_images;
  MyUser myuser;

  LikeTime(this.time, this.post_images, this.myuser);
  LikeTime.From(dynamic json)
      : time = json["time"],
        post_images = json["post_images"],
        myuser = MyUser.FromJson(json["myuser"]);

  Map<String, dynamic> ToJson() => {
        'time': time,
        'post_images': post_images,
        'myuser': myuser.Tojson(),
      };
}
