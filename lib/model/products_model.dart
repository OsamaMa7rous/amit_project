// To parse this JSON data, do
//
//     final productsVm = productsVmFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

ProductsVm productsVmFromJson(String str) => ProductsVm.fromJson(json.decode(str));

String productsVmToJson(ProductsVm data) => json.encode(data.toJson());

class ProductsVm {
  ProductsVm({
    this.products,
  });

  List<Product>? products;

  factory ProductsVm.fromJson(Map<String, dynamic> json) => ProductsVm(
    products: json["products"] == null ? null : List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "products": products == null ? null : List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class Product {
  Product({
    this.id,
    this.count,
    this.name,
    this.title,
    this.categoryId,
    this.description,
    this.price,
    this.discount,
    this.discountType,
    this.currency,
    this.inStock,
    this.avatar,
    this.priceFinal,
    this.priceFinalText,
  });

  int? id;
  int? count ;
  String? name;
  String? title;
  int? categoryId;
  String? description;
  int? price;
  int? discount;
  String? discountType;
  Currency? currency;
  int? inStock;
  String? avatar;
  double? priceFinal;
  String? priceFinalText;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"] == null ? null : json["id"],
    count: json["count"] == null ? null : json["count"],
    name: json["name"] == null ? null : json["name"],
    title: json["title"] == null ? null : json["title"],
    categoryId: json["category_id"] == null ? null : json["category_id"],
    description: json["description"] == null ? null : json["description"],
    price: json["price"] == null ? null : json["price"],
    discount: json["discount"] == null ? null : json["discount"],
    discountType: json["discount_type"] == null ? null : json["discount_type"],
    currency: json["currency"] == null ? null : currencyValues.map![json["currency"]],
    inStock: json["in_stock"] == null ? null : json["in_stock"],
    avatar: json["avatar"] == null ? null : json["avatar"],
    priceFinal: json["price_final"] == null ? null : json["price_final"].toDouble(),
    priceFinalText: json["price_final_text"] == null ? null : json["price_final_text"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "count": count == null ? null : count,
    "name": name == null ? null : name,
    "title": title == null ? null : title,
    "category_id": categoryId == null ? null : categoryId,
    "description": description == null ? null : description,
    "price": price == null ? null : price,
    "discount": discount == null ? null : discount,
    "discount_type": discountType == null ? null : discountType,
    "currency": currency == null ? null : currencyValues.reverse![currency],
    "in_stock": inStock == null ? null : inStock,
    "avatar": avatar == null ? null : avatar,
    "price_final": priceFinal == null ? null : priceFinal,
    "price_final_text": priceFinalText == null ? null : priceFinalText,
  };
}

enum Currency { EGP }

final currencyValues = EnumValues({
  "EGP": Currency.EGP
});

class EnumValues<T> {
  Map<String, T> ?map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
