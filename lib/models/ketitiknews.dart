// To parse required this JSON data, do
//
//     final keTitikNews = keTitikNewsFromJson(jsonString);

import 'dart:convert';

KeTitikNews keTitikNewsFromJson(String str) =>
    KeTitikNews.fromJson(json.decode(str));

String keTitikNewsToJson(KeTitikNews data) => json.encode(data.toJson());

class KeTitikNews {
  KeTitikNews({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<KetitikModel> data;

  factory KeTitikNews.fromJson(Map<String, dynamic> json) => KeTitikNews(
        success: json["Success"],
        message: json["Message"],
        data: List<KetitikModel>.from(
            json["Data"].map((x) => KetitikModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Success": success,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class KetitikModel {
  KetitikModel({
    required this.author,
    required this.source,
    required this.url,
    required this.image,
    required this.country,
    required this.category,
    required this.description,
    required this.id,
    required this.title,
    required this.newsType,
    required this.trending,
    required this.uploads_type,
    required this.bookmarks,
  });

  String? author;
  String? source;
  String? url;
  String? image;
  String? country;
  String? uploads_type;
  String? category;
  String? description;
  int id;
  String? title;
  String? newsType;
  int? trending;
  int? bookmarks;

  factory KetitikModel.fromJson(Map<String, dynamic> json) => KetitikModel(
        author: json["author"],
        source: json["source"],
        url: json["url"],
        image: json["image"],
        country: json["country"],
        category: json["category"],
        description: json["description"],
        id: json["id"],
        title: json["title"],
        newsType: json["news_type"],
        trending: json["trending"],
        uploads_type: json["uploads_type"],
        bookmarks: json["bookmarks"],
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
        "uploads_type": uploads_type,
        "title": title,
        "news_type": newsType,
        "trending": trending,
        "bookmarks": bookmarks,
      };
}
