import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_myinsta/models/myUser.dart';
import 'package:flutter_myinsta/models/post.dart';
import 'package:flutter_myinsta/services/share_prefs.dart';

class DataService {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  // set data
  static Future<void> SetNewData(Map<String, dynamic> data,
      [String posts = "User"]) async {
    var userid = await Prefs.Load();
    posts == "User"
        ? firestore.collection(posts).doc(userid).set(data)
        : firestore.collection(posts).add(data);
  }

  // load data
  static Future<Map<String, dynamic>> getData([String posts = "User"]) async {
    var userid = await Prefs.Load();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    Map<String, dynamic> alldata = posts == "User"
        ? (await firestore.collection(posts).doc(userid).get()).data() ?? {}
        : {"allPosts": (await firestore.collection(posts).get()).docs.toList()};
    return alldata;
  }

  // updata data
  static Updata(Map<String, Object?> data, [String posts = "User"]) async {
    var userid = await Prefs.Load();
    firestore.collection(posts).doc(userid).update(data);
  }

  static Updata_post2(Map<String, Object?> data, String Id) async {
    firestore.collection("all Users Posts").doc(Id).update(data);
    print(Id);
  }

  static Updata_post(Map<String, dynamic> data) async {
    firestore.collection("all Users Posts").get().then((value) async {
      final v = await value.docs.toList();
      for (var item in v) {
        Post p1 = Post.fromjson(item.data());
        Post p2 = Post.fromjson(data);
        if (p1.post_images[0] == p2.post_images[0]) {
          Updata_post2(data, item.id);
          break;
        }
      }
    });
    // update_user_posts();
  }

  static Future<String> following_add(MyUser user) async {
    var id = await Prefs.Load();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var get_user = await firestore.collection("User").get();
    var l = await get_user.docs.toList();
    for (var item in l) {
      var u = MyUser.FromJson(item.data());
      if (u.id == id) {
        u.following.add(user);
        await firestore.collection("User").doc(id).update(u.Tojson());
        await followers_add(user, u);
        break;
      }
    }
    return "ok";
  }

  static Future<String> followers_add(MyUser user, MyUser me) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var get_user = await firestore.collection("User").get();
    var l = await get_user.docs.toList();
    for (var item in l) {
      var u = MyUser.FromJson(item.data());
      if (u.id == user.id) {
        u.followers.add(me);
        await firestore.collection("User").doc(u.id).update(u.Tojson());
        break;
      }
    }
    return "ok";
  }

  static Future<String> following_del(MyUser user) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var id = await Prefs.Load();
    var get_user = await firestore.collection("User").doc(id).get();
    var myuser = MyUser.FromJson(get_user.data());
    int i = -1;
    for (var u in myuser.following) {
      i++;
      print("i");
      print("i = $i");
      if (u.id == user.id) {
        print(myuser.following.isEmpty);
        print(i);
        print(myuser.following.length);
        myuser.following.removeAt(i);
        await firestore.collection("User").doc(id).update(myuser.Tojson());
        await followers_del(user, id);
        break;
      }
    }
    return "ok";
  }

  static Future followers_del(MyUser user, String id) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var get_user = await firestore.collection("User").doc(user.id).get();
    var myuser = MyUser.FromJson(get_user.data());
    int i = -1;
    for (var u in myuser.followers) {
      i++;
      if (u.id == id) {
        myuser.followers.removeAt(i);
        await firestore.collection("User").doc(user.id).update(myuser.Tojson());
        break;
      }
    }
  }
}
