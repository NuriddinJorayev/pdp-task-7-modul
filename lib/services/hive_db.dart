import 'package:hive/hive.dart';

class Hive_db {

  static set(String key, Map<String, dynamic> object) {
     var db = Hive.box('hive0');
    db.put(key, object);
  }

  static dynamic load(String key) {
     var db = Hive.box('hive0');
    return db.get(key);
  }

  static bool exist(String key) {
     var db = Hive.box('hive0');
    return db.containsKey(key);
  }

  static Delete(String key) {
     var db = Hive.box('hive0');
    db.delete(key);
  }
}
