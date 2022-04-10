import 'dart:io';

import 'package:flutter_myinsta/models/device_info_mathod.dart';
import 'package:flutter_myinsta/services/share_prefs.dart';
import 'package:platform_device_id/platform_device_id.dart';

class DeviceInfo {
  static Future<DeviceIM> DeviceParams() async {
    Map<String, String> params = {};
    String? deviceId = await PlatformDeviceId.getDeviceId;
    String token = await Prefs.LoadFCM();
    if (Platform.isIOS) {
      params.addAll(
          {'device_id': deviceId!, 'device_type': "I", 'device_token': token});
    } else if (Platform.isAndroid) {
      params.addAll({
        'device_id': deviceId!,
        'device_type': "A",
        'device_token': token,
      });
    }

    return DeviceIM.FromJson(params);
  }
}
