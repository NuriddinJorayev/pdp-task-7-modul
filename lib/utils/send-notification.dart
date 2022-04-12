import 'dart:io';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_myinsta/models/notification_moled.dart';
import 'package:flutter_myinsta/services/send_http.dart';

class Sendnotification {
  static Send(String title, String body, List<String> token) {
    //  List<String> tokens = [];
    // tokens.add(
    //     "driFEfpHSmO_vjDu4wcvRW:APA91bECx-JyJdBp_AhsK7178u4kQMIjyfPChH_wDO8cnChyKlQSrJxOLPWzzr9g9GIGkgivA_91QximR3RnBS1dZlxnXl7uPCRvjHhTz18ng3JKB8TvJXza4dmZBPIh57eFxSwYsdto");
    // var my_device_id =
    //     "AAAAEf3Wb6s:APA91bFr8xrZL8THyM44Ct_DcEGnzkLeyal4hVW3VtMQU_F-6TRXt27pGTi3H6xWe2ZrkmzCQI8le2s4BMQo9i_JZHtB1Snp63CcDGY5polwTSOhNWp9ISV1OVJaGbXBYNiGP3e7paf3";
    var base_body = NotificationModel(title, body, token);
    var v = Http_notification();
    print(base_body.ToJson());
    v.show(base_body.ToJson());
  }

  static local_notifivvation(String title, String body) async {
    var android = AndroidNotificationDetails("channelId", "channelName",
        channelDescription: "channelDescription");
    var ios = IOSNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: ios);

    int id = Random().nextInt(pow(2, 31).toInt() - 1);

    await FlutterLocalNotificationsPlugin().show(id, title, body, platform);
  }
}
