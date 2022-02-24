class MyUser {
  String id ;
  String user_image;
  String name;
  String userName;
  String bio;
  List posts;
  // List<friend_user> posts;
  int followers;
  int following;

  MyUser(this.id, this.user_image, this.name, this.userName,
    this.bio, this.posts, this.followers, this.following);

  MyUser.FromJson(dynamic json)
      : this.user_image = json["user_image"],
        this.name = json["name"],
        this.id = json["id"],
        this.userName = json["userName"],
        this.bio = json["bio"],
        this.posts = json["posts"],
        this.followers = int.parse(json["followers"]),
        this.following = int.parse(json["following"]);

  Map<String, dynamic> Tojson() => {
        "user_image": user_image,
        "name": name,
        "id": id,
        "userName": userName,
        "bio": bio,
        "posts": posts,
        "followers": followers.toString(),
        "following": following.toString()
      };

      bool operator(MyUser user)=>
      ( this.user_image == user.user_image &&
        this.name == user.name &&
        this.id == user.id &&
        this.userName == user.userName &&
        this.bio == user.bio &&
        this.posts.length == user.posts.length &&
        this.followers == user.followers &&
        this.following == user.following);

}
