class Post {
  List<String> image_url;
  String caption;
  String likes;
  bool isliked;
  String time;
  String user_image;
  String userId;

  Post(this.image_url, this.caption, this.likes, this.isliked, this.time, this.user_image, this.userId);

  Post.fromjson(dynamic json)
      : image_url = List<String>.from(json["image_url"].map((e)=> e.toString())),
        caption = json["caption"],
        likes = json["likes"],
        isliked = json["isliked"],
        time = json["time"],
        user_image = json["user_image"],
        userId = json["userId"];

  Map<String, dynamic> ToJson() => {
        'image_url': [image_url.map((e) => e.toString())],
        'caption': caption,
        'likes': likes,
        'isliked': isliked,
        'time': time,
        'user_image': user_image,
        'userId': userId
      };
}
