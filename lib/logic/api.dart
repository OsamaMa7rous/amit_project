import 'dart:convert';
import 'package:amit_project/model/categories_model.dart';
import 'package:amit_project/model/products_model.dart';
import 'package:http/http.dart' as http;

class API {
  static Future<CategoriesVm> getCategories() async {
    String url = "https://retail.amit-learning.com/api/categories";

    final response = await http.get(Uri.parse(url));

    return CategoriesVm.fromJson(
        Map<String, dynamic>.from(json.decode(response.body.toString())));
  }

  static Future<ProductsVm> getProducts() async {
    String url = "https://retail.amit-learning.com/api/products";

    final response = await http.get(Uri.parse(url));

    return ProductsVm.fromJson(
        Map<String, dynamic>.from(json.decode(response.body.toString())));
  }
}
