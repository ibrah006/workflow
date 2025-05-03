import 'dart:convert';

import 'package:workflow/core/api/api_client.dart';
import 'package:workflow/core/api/endpoints.dart';
import 'package:workflow/core/api/local_http.dart';
import 'package:workflow/data/models/layoff_log.dart';

class LayoffLogService {
  static Future<List<LayoffLog>> fetchLayoffs() async {
    final response = await ApiClient.http.get(ApiEndpoints.getLayoffLogs);

    if (response.statusCode != 200) {
      throw "Failed to fetch layoffs: ${response.body}";
    }

    final body = jsonDecode(response.body);
    return (body as List).map((e) => LayoffLog.fromJson(e)).toList();
  }

  static Future<void> startLayoff(LayoffLog log) async {
    final headers = await LocalHttp.getHeaders();
    final response =
        await ApiClient.http.post(ApiEndpoints.startLayoff, headers: headers);

    if (response.statusCode != 200) {
      throw "Error creating layoff record: ${response.body}";
    }
  }

  static Future<void> endLayoff(LayoffLog log) async {
    final headers = await LocalHttp.getHeaders();
    final response =
        await ApiClient.http.post(ApiEndpoints.endLayoff, headers: headers);

    if (response.statusCode != 200) {
      throw "Error ending layoff record: ${response.body}";
    }
  }
}
