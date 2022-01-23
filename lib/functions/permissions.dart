
import 'package:permission_handler/permission_handler.dart';

class MyPermission_status {
  static RequestPermission() async {
    var status = await Permission.storage.status;

      Permission.storage.request();
    
    
  }
}
