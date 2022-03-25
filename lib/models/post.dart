import 'package:flutter_myinsta/models/comment.dart';
import 'package:flutter_myinsta/models/myUser.dart';

class Post {
  String user_image;
  String user_name;
  String location;
  List post_images;
  List<MyUser> likes;
  String caption;
  List<Comment> comments;
  String time;
  String userId;

  Post(this.user_image, this.user_name, this.location, this.post_images,
      this.likes, this.caption, this.comments, this.time, this.userId);

  Post.fromjson(dynamic json)
      : user_image = json['user_image'],
        user_name = json['user_name'],
        location = json['location'],
        post_images = json['post_images'],
        likes = json['likes'].isEmpty
            ? []
            : List<MyUser>.from(json['likes'].map((e) => MyUser.FromJson(e))),
        caption = json['caption'],
        comments = List<Comment>.from(
            json['comments'].map((e) => Comment.FromJson(e))),
        time = json['time'],
        userId = json['userId'];

  Map<String, dynamic> ToJson() => {
        'user_image': user_image,
        'user_name': user_name,
        'location': location,
        'post_images': post_images,
        'likes': likes.map((e) => e.Tojson()).toList(),
        'caption': caption,
        'comments': comments.map((e) => e.ToJson()).toList(),
        'time': time,
        'userId': userId,
      };
}
