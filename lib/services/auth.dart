import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/configApi.dart';

class AuthService {

  Future<bool> login({
    required String username,
    required String password,
  }) async {

    final url =Uri.parse("${ConfigApi.baseUrl}/auth/login");

    final response = await http.post(
  url,
  headers: {
    "Accept": "application/json",
  },
  body: {
    'username': username,
    'password': password,
  },
);

print(response.statusCode);
print(response.body);

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      String token = data['data']['token'];

      SharedPreferences prefs =
          await SharedPreferences.getInstance();

      await prefs.setString("token", token);

      return true;

    } else {

      print(response.body);

      return false;
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs =
        await SharedPreferences.getInstance();

    await prefs.remove("token");
  }
}