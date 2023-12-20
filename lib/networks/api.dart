import 'dart:convert';

import '../models/products.dart';
import 'package:http/http.dart' as http;

class API {
  static String baseURL = 'https://fakestoreapi.com/products';
  static String categoryList = 'https://fakestoreapi.com/products/category';

  Future<List<Products>> getAllProducts() async {
    final response = await http
        .get(Uri.parse(baseURL), headers: {"Content-Type": "application/json"});
    final List body = json.decode(response.body);
    return body.map((e) => Products.fromJson(e)).toList();
  }
}
