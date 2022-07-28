// To parse required this JSON data, do
//
//     final bookMarkData = bookMarkDataFromJson(jsonString);

import 'dart:convert';

BookMarkModel bookMarkDataFromJson(String str) =>
    BookMarkModel.fromJson(json.decode(str));

String bookMarkDataToJson(BookMarkModel data) => json.encode(data.toJson());

class BookMarkModel {
  BookMarkModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<BookMarkData> data;

  factory BookMarkModel.fromJson(Map<String, dynamic> json) => BookMarkModel(
        status: json["status"],
        message: json["message"],
        data: List<BookMarkData>.from(
            json["data"].map((x) => BookMarkData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class BookMarkData {
  BookMarkData({
    required this.id,
    required this.title,
    required this.userId,
    required this.deviceId,
    required this.url,
    required this.bmkId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.author,
    required this.source,
    required this.image,
    required this.country,
    required this.category,
    required this.description,
    required this.newsType,
    required this.trending,
  });

  int? id;
  String? title;
  String? userId;
  String? deviceId;
  String? url;
  int? bmkId;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? author;
  String? source;
  String? image;
  String? country;
  String? category;
  String? description;
  String? newsType;
  int? trending;

  factory BookMarkData.fromJson(Map<String, dynamic> json) => BookMarkData(
        id: json["id"],
        title: json["title"],
        userId: json["user_id"],
        deviceId: json["device_id"],
        url: json["url"],
        bmkId: json["bmk_id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        author: json["author"],
        source: json["source"],
        image: json["image"],
        country: json["country"],
        category: json["category"],
        description: json["description"],
        newsType: json["news_type"],
        trending: json["trending"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "user_id": userId,
        "device_id": deviceId,
        "url": url,
        "bmk_id": bmkId,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "author": author,
        "source": source,
        "image": image,
        "country": country,
        "category": category,
        "description": description,
        "news_type": newsType,
        "trending": trending,
      };
}
