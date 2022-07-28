// To parse this JSON data, do
//
//     final categoryData = categoryDataFromJson(jsonString);

import 'dart:convert';

CategoryData categoryDataFromJson(String str) =>
    CategoryData.fromJson(json.decode(str));

String categoryDataToJson(CategoryData data) => json.encode(data.toJson());

class CategoryData {
  CategoryData({
    required this.status,
    required this.data,
  });

  String status;
  List<Preference> data;

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
        status: json["status"],
        data: List<Preference>.from(
            json["data"].map((x) => Preference.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Preference {
  Preference({
    required this.id,
    required this.categories,
    required this.thumbImage,
  });

  int id;
  String categories;
  String thumbImage;

  factory Preference.fromJson(Map<String, dynamic> json) => Preference(
        id: json["id"],
        categories: json["categories"],
        thumbImage: json["thumb_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "categories": categories,
        "thumb_image": thumbImage,
      };
}
