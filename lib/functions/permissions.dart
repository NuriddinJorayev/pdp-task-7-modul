import 'package:permission_handler/permission_handler.dart';

class MyPermission_status {
  static Request_storage() async {
    var status1 = await Permission.storage.status;
    if (status1.isGranted || status1.isDenied) {
      Permission.storage.request();
    }
  }

  static Request_manageExternalStorage() async {
    var status2 = await Permission.manageExternalStorage.status;   
    if (status2.isGranted || status2.isDenied) {
      Permission.manageExternalStorage.request();
    }
  }
}
