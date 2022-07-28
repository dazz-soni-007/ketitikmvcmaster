// To parse this JSON data, do
//
//     final preference = preferenceFromJson(jsonString);

import 'dart:convert';

Preferences preferenceFromJson(String str) =>
    Preferences.fromJson(json.decode(str));

String preferenceToJson(Preferences data) => json.encode(data.toJson());

class Preferences {
  Preferences({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  Data data;

  factory Preferences.fromJson(Map<String, dynamic> json) => Preferences(
        success: json["Success"],
        message: json["Message"],
        data: Data.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Success": success,
        "Message": message,
        "Data": data.toJson(),
      };
}

class Data {
  Data({
    required this.categorySaved,
    required this.categoryName,
  });

  String categorySaved;
  List<CategoryName> categoryName;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        categorySaved: json["category_saved"],
        categoryName: List<CategoryName>.from(
            json["category_name"].map((x) => CategoryName.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category_saved": categorySaved,
        "category_name":
            List<dynamic>.from(categoryName.map((x) => x.toJson())),
      };
}

class CategoryName {
  CategoryName({
    required this.id,
    required this.categories,
  });

  int id;
  String categories;

  factory CategoryName.fromJson(Map<String, dynamic> json) => CategoryName(
        id: json["id"],
        categories: json["categories"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "categories": categories,
      };
}
