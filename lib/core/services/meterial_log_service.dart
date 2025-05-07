import 'dart:convert';
import 'package:workflow/core/api/api_client.dart';
import 'package:workflow/core/api/endpoints.dart';
import 'package:workflow/data/models/material_log.dart';

class MaterialLogService {
  Future<List<MaterialLog>> fetchLogs() async {
    final response = await ApiClient.http.get(ApiEndpoints.materialLogs);

    if (response.statusCode != 200) {
      throw "Error fetching all logs with status code: ${response.statusCode}";
    }

    return (jsonDecode(response.body) as List)
        .map((rawLog) => MaterialLog.fromJson(rawLog as Map<String, dynamic>))
        .toList();
  }

  Future<MaterialLog> fetchLog(int id) async {
    final response =
        await ApiClient.http.get(ApiEndpoints.getMaterialLogById(id));
    if (response.statusCode != 200) {
      throw "Error fetching log with id $id";
    }
    return MaterialLog.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }

  Future<bool> createLog(MaterialLog log) async {
    final response = await ApiClient.http.post(ApiEndpoints.materialLogs);

    return response.statusCode == 200;
  }
}
