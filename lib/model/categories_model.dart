// To parse this JSON data, do
//
//     final categoriesVm = categoriesVmFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

CategoriesVm categoriesVmFromJson(String str) => CategoriesVm.fromJson(json.decode(str));

String categoriesVmToJson(CategoriesVm data) => json.encode(data.toJson());

class CategoriesVm {
  CategoriesVm({
    this.categories,
  });

  List<Category>? categories;

  factory CategoriesVm.fromJson(Map<String, dynamic> json) => CategoriesVm(
    categories: json["categories"] == null ? null : List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "categories": categories == null ? null : List<dynamic>.from(categories!.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    this.id,
    this.name,
    this.avatar,
  });

  int? id;
  String? name;
  String? avatar;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    avatar: json["avatar"] == null ? null : json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "avatar": avatar == null ? null : avatar,
  };
}
