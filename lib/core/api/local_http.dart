import 'dart:convert';

import 'package:http/http.dart' as http;

class LocalHttp {
  String baseUrl;

  LocalHttp({required this.baseUrl});

  Future<http.Response> get(String endpoint) async {
    print('stock get url endpoint: $baseUrl$endpoint');
    return await http.get(Uri.parse('$baseUrl$endpoint'));
  }

  Future<http.Response> post(String endpoint,
      {Map<String, dynamic>? body}) async {
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
