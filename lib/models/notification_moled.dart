class NotificationModel {
  String title;
  String body;
  List<String> registration_ids;

  NotificationModel(this.title, this.body, this.registration_ids);

  NotificationModel.fromjson(dynamic json)
      : title = _Notification.fromjson(json["notification"]).title,
        body = _Notification.fromjson(json["notification"]).body,
        registration_ids = json["registration_ids"] as List<String>;

  Map<String, dynamic> ToJson() => {
        'notification': _Notification(title, body).toJson(),
        'registration_ids': registration_ids.toList(),
      };
}

class _Notification {
  String title;
  String body;
  _Notification(this.title, this.body);

  _Notification.fromjson(dynamic json)
      : title = json["title"],
        body = json["body"];

  Map<String, dynamic> toJson() => {
        'title': title,
        'body': body,
      };
}
