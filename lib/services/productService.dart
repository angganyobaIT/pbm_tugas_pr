import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/configApi.dart';
import '../models/productModel.dart';

class ProductService {

  Future<bool> addProduct({
    required String name,
    required int price,
    required String description,
  }) async {

    SharedPreferences prefs =
        await SharedPreferences.getInstance();

    String token =
        prefs.getString("token") ?? "";

    final url =
        Uri.parse("${ConfigApi.baseUrl}/products");

    final response = await http.post(
      url,

      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },

      body: {
        "name": name,
        "price": price.toString(),
        "description": description,
      },
    );

    return response.statusCode == 200 ||
        response.statusCode == 201;
  }
  Future<List<ProductModel>> getProducts() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String token =prefs.getString("token") ?? "";

    final url = Uri.parse("${ConfigApi.baseUrl}/products");

    final response = await http.get(
      url,

      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );

    final data = jsonDecode(response.body);
    List products =
        data['data']['products'];

    return products
        .map((item) => ProductModel.fromJson(item))
        .toList();
  }
  
  Future<bool> deleteProduct(int id) async {

    SharedPreferences prefs =
        await SharedPreferences.getInstance();
    String token =
        prefs.getString("token") ?? "";
    final url =
        Uri.parse(
          "${ConfigApi.baseUrl}/products/$id",
        );
    final response = await http.delete(
      url,

      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );
    return response.statusCode == 200;
  }
}