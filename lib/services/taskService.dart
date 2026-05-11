import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/configApi.dart';

class TaskService {

  Future<bool> submitTask({
    required String name,
    required String price,
    required String description,
    required String githubUrl,
  }) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String token =prefs.getString("token") ?? "";

    final url = Uri.parse(
      "${ConfigApi.baseUrl}/products/submit",
    );

    final response = await http.post(

      url,

      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
        "Content-Type":
            "application/json",
      },

      body: jsonEncode({
        "name": name,
        "price":int.parse(price),
        "description":
            description,
        "github_url":
            githubUrl,
      }),
    );
    return response.statusCode == 200 ||
        response.statusCode == 201;
  }
}