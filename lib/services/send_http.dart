import 'dart:convert';

import 'package:http/http.dart' as http;

class Http_notification {
  Future<void> show(Map<String, dynamic> body) async {
    var url = Uri.parse("https://fcm.googleapis.com/fcm/send");
    var headers = {
      "Authorization":
          "key=AAAAEf3Wb6s:APA91bFr8xrZL8THyM44Ct_DcEGnzkLeyal4hVW3VtMQU_F-6TRXt27pGTi3H6xWe2ZrkmzCQI8le2s4BMQo9i_JZHtB1Snp63CcDGY5polwTSOhNWp9ISV1OVJaGbXBYNiGP3e7paf3",
      'Content-Type': 'application/json; charset=UTF-8',
    };
    var response =
        await http.post(url, body: jsonEncode(body), headers: headers);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}
