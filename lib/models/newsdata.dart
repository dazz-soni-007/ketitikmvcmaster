// To parse this JSON data, do
//
//     final newsData = newsDataFromJson(jsonString);

import 'dart:convert';

NewsData newsDataFromJson(String str) => NewsData.fromJson(json.decode(str));

String newsDataToJson(NewsData data) => json.encode(data.toJson());

class NewsData {
  NewsData({
    required this.success,
    required this.message,
    required this.data,
  });
  bool success;
  String message;
  List<DataArticle> data;

  factory NewsData.fromJson(Map<String, dynamic> json) => NewsData(
        success: json["Success"],
        message: json["Message"],
        data: List<DataArticle>.from(
            json["Data"].map((x) => DataArticle.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Success": success,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataArticle {
  DataArticle({
    required this.author,
    required this.source,
    required this.url,
    required this.image,
    required this.country,
    required this.category,
    required this.description,
    required this.id,
    required this.title,
  });
  String? author;
  String? source;
  String? url;
  String? image;
  String? country;
  String? category;
  String? description;
  int? id;
  String? title;

  factory DataArticle.fromJson(Map<String, dynamic> json) => DataArticle(
        author: json["author"],
        source: json["source"],
        url: json["url"],
        image: json["image"],
        country: json["country"],
        category: json["category"],
        description: json["description"],
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "source": source,
        "url": url,
        "image": image,
        "country": country,
        "category": category,
        "description": description,
        "id": id,
        "title": title,
      };

  static Map<String, dynamic> toMap(DataArticle dataArticle) => {
        "author": dataArticle.author,
        "source": dataArticle.source,
        "url": dataArticle.url,
        "image": dataArticle.image,
        "country": dataArticle.country,
        "category": dataArticle.category,
        "description": dataArticle.description,
        "id": dataArticle.id,
        "title": dataArticle.title,
      };

  static String encode(List<DataArticle> musics) => json.encode(
        musics
            .map<Map<String, dynamic>>((music) => DataArticle.toMap(music))
            .toList(),
      );

  static List<DataArticle> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<DataArticle>((item) => DataArticle.fromJson(item))
          .toList();
}
