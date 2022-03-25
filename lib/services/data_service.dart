import 'package:cloud_firestore/cloud_firestore.dart';
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
  }
}
