import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  // save method
  static Future<bool> Save(String id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("userId", id);
    return pref.getKeys().contains(id);
  }

  // load method
  static Future<String> Load() async {
    String? pref = (await SharedPreferences.getInstance()).getString("userId");
    return pref ?? "";
  }

  // delete method
  static Future<bool> Delete() async {
    return (await SharedPreferences.getInstance()).remove("userId");
  }

  static Future<bool> SaveFCM(String data) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("FCM", data);
    return pref.getKeys().contains(data);
  }

  static Future<String> LoadFCM() async {
    String? pref = (await SharedPreferences.getInstance()).getString("FCM");
    return pref ?? "";
  }
}
