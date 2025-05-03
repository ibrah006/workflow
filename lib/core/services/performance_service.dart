import 'dart:convert';

import 'package:workflow/core/api/api_client.dart';
import 'package:workflow/core/api/endpoints.dart';
import 'package:workflow/core/api/local_http.dart';
import 'package:workflow/core/enums/shared_storage_options.dart';
import 'package:workflow/data/performance_score.dart';

class PerformanceService {
  static Future<PerformanceScore> getUserPerformance({String? userId}) async {
    final response = await ApiClient.http.get(userId == null
        ? ApiEndpoints.getUserPerformance
        : ApiEndpoints.getUsersPerformance);

    if (response.statusCode != 200) {
      throw "Failed to fetch performance summary for current user: ${response.body}";
    }

    userId = userId ??
        LocalHttp.prefs.get(SharedStorageOptions.uuid.name).toString();

    final body = jsonDecode(response.body);
    return PerformanceScore.fromJson({...body, "userId": userId});
  }
}
