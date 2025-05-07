import 'dart:convert';

import 'package:workflow/core/api/api_client.dart';
import 'package:workflow/core/api/endpoints.dart';
import 'package:workflow/data/models/project.dart';

class ProjectService {
  static Future<List<Project>> fetchProjects() async {
    final response = await ApiClient.http.get(ApiEndpoints.projects);
    final body = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw "Failed to fetch tasks: ${response.body}";
    }

    return (body as List).map((e) => Project.fromJson(e)).toList();
  }
}
