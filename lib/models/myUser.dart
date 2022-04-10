import 'package:flutter_myinsta/models/device_info_mathod.dart';

class MyUser {
  String id;
  String user_image;
  String name;
  String userName;
  String bio;
  int posts;
  List<MyUser> followers;
  List<MyUser> following;
  DeviceIM device_info;

  MyUser(this.id, this.user_image, this.name, this.userName, this.bio,
      this.posts, this.followers, this.following, this.device_info);

  MyUser.FromJson(dynamic json)
      : this.user_image = json["user_image"] ?? "",
        this.name = json["name"] ?? "",
        this.id = json["id"],
        this.posts = int.parse(json["posts"]),
        this.userName = json["userName"] ?? "",
        this.bio = json["bio"] ?? "",
        this.followers = json["followers"] != null
            ? List<MyUser>.from(
                json["followers"].map((e) => MyUser.FromJson(e)))
            : [],
        this.following = json["following"] != null
            ? List<MyUser>.from(
                json["following"].map((e) => MyUser.FromJson(e)))
            : [],
        this.device_info = DeviceIM.FromJson(json["device_info"]);

  Map<String, dynamic> Tojson() => {
        "user_image": user_image,
        "name": name,
        "id": id,
        "posts": posts.toString(),
        "userName": userName,
        "bio": bio,
        "followers": followers.map((e) => e.Tojson()).toList(),
        "following": following.map((e) => e.Tojson()).toList(),
        "device_info": device_info.ToJson()
      };

  bool operator(MyUser user) => (this.user_image == user.user_image &&
      this.name == user.name &&
      this.id == user.id &&
      this.userName == user.userName &&
      this.bio == user.bio &&
      this.followers.length == user.followers.length &&
      this.following.length == user.following.length);
}
