import 'package:flutter_myinsta/models/post.dart';

class MyUser {
  String id;
  String user_image;
  String name;
  String userName;
  String bio;
  List<Post> posts;
  // List<friend_user> posts;
  int followers;
  int following;

  MyUser(this.id, this.user_image, this.name, this.userName, this.bio,
      this.posts, this.followers, this.following);

  MyUser.FromJson(dynamic json)
      : this.user_image = json["user_image"] ?? "",
        this.name = json["name"] ?? "",
        this.id = json["id"],
        this.userName = json["userName"] ?? "",
        this.bio = json["bio"] ?? "",
        this.posts = json["posts"] != null
            ? List<Post>.from(json["posts"].map((e) => Post.fromjson(e)))
            : [],
        this.followers = int.parse(json["followers"] ?? "0"),
        this.following = int.parse(json["following"] ?? "0");

  Map<String, dynamic> Tojson() => {
        "user_image": user_image,
        "name": name,
        "id": id,
        "userName": userName,
        "bio": bio,
        "posts": posts.map((e) => e.ToJson()).toList(),
        "followers": followers.toString(),
        "following": following.toString()
      };

  bool operator(MyUser user) => (this.user_image == user.user_image &&
      this.name == user.name &&
      this.id == user.id &&
      this.userName == user.userName &&
      this.bio == user.bio &&
      this.posts.length == user.posts.length &&
      this.followers == user.followers &&
      this.following == user.following);
}
