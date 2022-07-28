// To parse this JSON data, do
//
//     final newsAll = newsAllFromJson(jsonString);

import 'dart:convert';

NewsAll newsAllFromJson(String str) => NewsAll.fromJson(json.decode(str));

String newsAllToJson(NewsAll data) => json.encode(data.toJson());

class NewsAll {
  NewsAll({
    required this.success,
    required this.message,
    required this.data,
  });
  bool success;
  String message;
  List<Article> data;

  factory NewsAll.fromJson(Map<String, dynamic> json) => NewsAll(
        success: json["Success"],
        message: json["Message"],
        data: List<Article>.from(json["Data"].map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Success": success,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Article {
  Article({
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
  String author;
  String source;
  String url;
  String image;
  String country;
  String category;
  String description;
  int id;
  String title;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        author: json["author"],
        source: json["source"],
        url: json["url"],
        image: json["image"] == null ? null : json["image"],
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
        "image": image == null ? null : image,
        "country": country,
        "category": category,
        "description": description,
        "id": id,
        "title": title,
      };
}
