// To parse this JSON data, do
//
//     final staticPrivacy = staticPrivacyFromJson(jsonString);

import 'dart:convert';

StaticPrivacy staticPrivacyFromJson(String str) =>
    StaticPrivacy.fromJson(json.decode(str));

String staticPrivacyToJson(StaticPrivacy data) => json.encode(data.toJson());

class StaticPrivacy {
  StaticPrivacy({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<DataPrivacy> data;

  factory StaticPrivacy.fromJson(Map<String, dynamic> json) => StaticPrivacy(
        status: json["status"],
        message: json["message"],
        data: List<DataPrivacy>.from(
            json["data"].map((x) => DataPrivacy.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataPrivacy {
  DataPrivacy({
    required this.privacy,
  });

  String privacy;

  factory DataPrivacy.fromJson(Map<String, dynamic> json) => DataPrivacy(
        privacy: json["privacy"],
      );

  Map<String, dynamic> toJson() => {
        "privacy": privacy,
      };
}
