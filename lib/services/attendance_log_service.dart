import 'dart:convert';

import 'package:workflow/core/api/api_client.dart';
import 'package:workflow/core/api/endpoints.dart';
import 'package:workflow/core/api/local_http.dart';
import 'package:workflow/core/enums/log_data_analysis_for.dart';
import 'package:workflow/core/models/attendance_log.dart';
import 'package:workflow/data/attendance_analysis_data.dart';

class AttendanceLogService {
  static Future<List<AttendanceLog>> getLogs() async {
    final response = await ApiClient.http.get(ApiEndpoints.getAttendanceLogs);

    if (response.statusCode != 200) {
      throw "Error getting attendance logs: ${response.body}";
    }

    final body = jsonDecode(response.body);
    return (body as List).map((e) => AttendanceLog.fromJson(e)).toList();
  }

  static Future<AttendanceLog?> getActiveLog() async {
    final response = await ApiClient.http.get(
      ApiEndpoints.getUserActiveAttendanceLog,
    );

    final responseBody =
        (jsonDecode(response.body) as Map)["active"] as Map<String, dynamic>?;
    print("current active log raw from body: ${responseBody}");
    return responseBody != null ? AttendanceLog.fromJson(responseBody) : null;
  }

  static Future<AttendanceLog?> clockIn() async {
    final response = await ApiClient.http.post(
      headers: await LocalHttp.getHeaders(),
      hasJsonHeaders: false,
      ApiEndpoints.clockInUser,
    );

    final activatedLog =
        (jsonDecode(response.body) as Map)["log"] as Map<String, dynamic>?;

    print("activated log: ${jsonDecode(response.body) as Map}");

    return activatedLog != null ? AttendanceLog.fromJson(activatedLog) : null;
  }

  static Future<bool> clockOut() async {
    final response = await ApiClient.http.post(ApiEndpoints.clockOut,
        headers: await LocalHttp.getHeaders(), hasJsonHeaders: false);

    return response.statusCode == 200;
  }

  // Attendance log analysis
  static Future<AttendanceAnalysisData> fetchAnalysisData(
      LogAnalysisDataFor dataFor) async {
    final response = await ApiClient.http.get(
        ApiEndpoints.getUserAttendanceLogAnalysis,
        queries: "?for=${dataFor.name}");

    return AttendanceAnalysisData.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  }
}
