import 'dart:convert';

import 'package:workflow/core/api/api_client.dart';
import 'package:workflow/core/api/endpoints.dart';
import 'package:workflow/core/models/user.dart';
import 'package:workflow/core/models/work_activity_log.dart';

class WorkActivityLogService {
  // Fetch active work activity log for current user
  static Future<WorkActivityLog?> fetchActiveWorkActivityLog() async {
    final response =
        await ApiClient.http.get(ApiEndpoints.getUserActiveWorkActivityLog);
    if (response.statusCode == 200) {
      final responseBody =
          (jsonDecode(response.body) as Map)["active"] as Map<String, dynamic>?;

      if (responseBody != null) {
        responseBody["user"] = User.currentUser();
        print("response body: ${responseBody}");
        return WorkActivityLog.fromJson(responseBody);
      } else {
        throw "Unexpected Exception with server";
      }
    }
    return null;
  }
}
