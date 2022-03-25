import 'package:flutter_myinsta/models/myUser.dart';
import 'package:flutter_myinsta/services/share_prefs.dart';

class Temp_data {
  static MyUser user = MyUser(getId(), "", "", "", '', [], 0, 0);
  static getId() async {
    return await Prefs.Load();
  }

  static bool isplay = true;
}
