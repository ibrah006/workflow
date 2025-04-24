import 'package:workflow/core/api/api_client.dart';
import 'package:workflow/core/api/enpoints.dart';
import 'package:workflow/core/models/User.dart';

class LoginService {
  static Future<bool> login(
      {required String email, required String password}) async {
    final response = await ApiClient.http.post(
      ApiEndpoints.login,
      body: {"email": email, "password": password},
    );

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
}
