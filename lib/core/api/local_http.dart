import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workflow/core/enums/shared_storage_options.dart';

class LocalHttp {
  String baseUrl;

  LocalHttp({required this.baseUrl});

  static late final SharedPreferences prefs;

  Future<Map<String, String>> getHeaders() async {
    try {
      final jwtToken = prefs.get(SharedStorageOptions.jwtToken.name);
      return {"Authorization": "Bearer $jwtToken"};
    } catch (e) {
      prefs = await SharedPreferences.getInstance();
      return await getHeaders();
    }
  }

  Future<http.Response> get(String endpoint) async {
    final headers = await getHeaders();
    print("headers: ${headers}");
    return await http.get(Uri.parse('$baseUrl$endpoint'), headers: headers);
  }

  Future<http.Response> post(String endpoint,
      {Map<String, dynamic>? body}) async {
    print("POST $baseUrl$endpoint, body: ${body}");
    return await http.post(Uri.parse('$baseUrl$endpoint'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body));
  }

  Future<http.Response> put(String endpoint, {Map? body}) async {
    print("body before calling put: $body");
    return await http.put(Uri.parse('$baseUrl$endpoint'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body));
  }

  Future<http.Response> delete(String endpoint, {Map? body}) async {
    return await http.delete(Uri.parse('$baseUrl$endpoint'),
        body: jsonEncode(body));
  }
}
