import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:workflow/core/api/api_client.dart';
import 'package:workflow/core/api/endpoints.dart';
import 'package:workflow/core/enums/shared_storage_options.dart';
import 'package:workflow/core/models/User.dart';

class LoginService {
  static Future<bool> login({
    required String email,
    required String password,
  }) async {
    final response = await ApiClient.http.post(
      ApiEndpoints.login,
      body: {"email": email, "password": password},
    );

    final body = jsonDecode(response.body);

    print("response code: ${response.statusCode}, body: ${response.body}");

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedStorageOptions.jwtToken.name, body["token"]);

    final user = User.fromJson(body["user"]);
    await prefs.setString(SharedStorageOptions.uuid.name, user.id);
    await prefs.setString(SharedStorageOptions.displayName.name, user.name);
    await prefs.setString(SharedStorageOptions.email.name, user.email);
    await prefs.setString(SharedStorageOptions.userRole.name, user.role);

    return response.statusCode == 200;
  }

  static Future<void> register(
      {required User user, required String password}) async {
    final response = await ApiClient.http.post(
      ApiEndpoints.login,
      body: {...user.toJson(), "password": password},
    );

    if (response.statusCode != 200) {
      throw "Error registering user in:\n${response.body}\n";
    }
  }

  static Future<bool> isLoggedIn() async {
    try {
      final response =
          await ApiClient.http.get(ApiEndpoints.getCurrentUserInfo);
      print("status code: ${response.statusCode}");
      return response.statusCode == 200;
    } catch (e) {
      print("error: $e");
      throw "Error caught: $e";
    }
  }
}
