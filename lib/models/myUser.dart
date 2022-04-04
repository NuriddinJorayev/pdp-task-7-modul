import 'package:flutter_myinsta/models/post.dart';

class MyUser {
  String id;
  String user_image;
  String name;
  String userName;
  String bio;
  List<Post> posts;
  // List<friend_user> posts;
  List<MyUser> followers;
  List<MyUser> following;

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
        this.followers = json["followers"] != null
            ? List<MyUser>.from(
                json["followers"].map((e) => MyUser.FromJson(e)))
            : [],
        this.following = json["following"] != null
            ? List<MyUser>.from(
                json["following"].map((e) => MyUser.FromJson(e)))
            : [];

  Map<String, dynamic> Tojson() => {
        "user_image": user_image,
        "name": name,
        "id": id,
        "userName": userName,
        "bio": bio,
        "posts": posts.map((e) => e.ToJson()).toList(),
        "followers": followers.map((e) => e.Tojson()).toList(),
        "following": following.map((e) => e.Tojson()).toList()
      };

  bool operator(MyUser user) => (this.user_image == user.user_image &&
      this.name == user.name &&
      this.id == user.id &&
      this.userName == user.userName &&
      this.bio == user.bio &&
      this.posts.length == user.posts.length &&
      this.followers.length == user.followers.length &&
      this.following.length == user.following.length);
}
