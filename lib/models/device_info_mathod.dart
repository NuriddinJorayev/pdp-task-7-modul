class DeviceIM {
  String device_id;
  String device_type;
  String device_token;

  DeviceIM(this.device_id, this.device_type, this.device_token);
  DeviceIM.FromJson(dynamic json)
      : device_id = json["device_id"] ?? "",
        device_type = json["device_type"] ?? '',
        device_token = json["device_token"] ?? '';

  Map<String, String> ToJson() => {
        "device_id": device_id,
        "device_type": device_type,
        "device_token": device_token,
      };
}
