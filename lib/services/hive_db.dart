import 'package:hive/hive.dart';

class Hive_db {
  static var db = Hive.box('hive0');

  static set(String key, Map<String, dynamic> object) {
    db.put(key, object);
  }

  static dynamic load(String key) {
    return db.get(key);
  }

  static bool exist(String key) {
    return db.containsKey(key);
  }

  static Delete(String key) {
    db.delete(key);
  }
}
