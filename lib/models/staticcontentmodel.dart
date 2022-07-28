// To parse this JSON data, do
//
//     final staticContent = staticContentFromJson(jsonString);

import 'dart:convert';

StaticContent staticContentFromJson(String str) =>
    StaticContent.fromJson(json.decode(str));

String staticContentToJson(StaticContent data) => json.encode(data.toJson());

class StaticContent {
  StaticContent({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<DataTerms> data;

  factory StaticContent.fromJson(Map<String, dynamic> json) => StaticContent(
        status: json["status"],
        message: json["message"],
        data: List<DataTerms>.from(
            json["data"].map((x) => DataTerms.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataTerms {
  DataTerms({
    required this.terms,
  });

  String terms;

  factory DataTerms.fromJson(Map<String, dynamic> json) => DataTerms(
        terms: json["terms"],
      );

  Map<String, dynamic> toJson() => {
        "terms": terms,
      };
}
