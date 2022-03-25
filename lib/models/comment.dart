import 'package:flutter_myinsta/models/myUser.dart';

class Comment {
  String user_image;
  String user_name;
  String caption;
  String time;
  List<MyUser> likes;

  Comment(this.user_image, this.user_name, this.caption, this.time, this.likes);

  Comment.FromJson(dynamic json)
      : this.user_image = json["user_image"],
        this.user_name = json["user_name"],
        this.caption = json["caption"],
        this.time = json["time"],
        this.likes = List<MyUser>.from(json["likes"].map((e) => MyUser.FromJson(e)));

   Map<String, dynamic> ToJson() => {
     'user_image' : user_image,
     'user_name' : user_name,
     'caption' : caption,
     'time' : time,
     'likes' : List<MyUser>.from(likes.map((e) => e.Tojson())),
   };     
}
