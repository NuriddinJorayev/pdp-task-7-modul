import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_myinsta/services/share_prefs.dart';

class DataService {
   static FirebaseFirestore firestore = FirebaseFirestore.instance;
   // set data
  static Future<void> SetNewData(Map<String, dynamic> data)async{  
    var userid  =await Prefs.Load();
   firestore.collection("User").doc(userid).set(data);
  }
  // load data
  static Future<Map<String, dynamic>> getData()async{  
      var userid  =await Prefs.Load();
FirebaseFirestore firestore = FirebaseFirestore.instance;
Map<String, dynamic> alldata = (await firestore.collection("User").doc(userid).get()).data()??{};
   return  alldata;
  }
  // updata data 
  static  Updata(Map<String, Object?> data)async{  
      var userid  =await Prefs.Load();
    firestore.collection("User").doc(userid).update(data);
  }
  
  
}