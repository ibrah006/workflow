import 'dart:convert';
import 'package:workflow/core/api/api_client.dart';
import 'package:workflow/core/api/endpoints.dart';
import 'package:workflow/core/api/local_http.dart';
import 'package:workflow/data/models/attendance_log.dart';
import 'package:workflow/data/models/work_activity_log.dart';
import 'package:workflow/data/models/task.dart';

class TaskService {
  static Future<List<Task>> fetchTasks() async {
    final response = await ApiClient.http.get(ApiEndpoints.getTasks);
    final body = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw "Failed to fetch tasks: ${response.body}";
    }

    return (body as List).map((e) => Task.fromJson(e)).toList();
  }

  static Future<void> createTask(Task task) async {
    final response = await ApiClient.http
        .post(ApiEndpoints.createTask(task.projectId), body: task.toJson());

    if (response.statusCode != 201) {
      throw "Error creating task:\n${response.body}";
    }
  }

  // Fetch tasks assigned to current user
  static Future<List<Task>> fetchUserTasks() async {
    final response = await ApiClient.http.get(ApiEndpoints.getUserTasks);

    if (response.statusCode != 200) {
      throw "Error fetching tasks for current user: ${response.body}";
    }

    final assignedTasks = (jsonDecode(response.body) as List).map((taskRaw) {
      return Task.fromJson(taskRaw as Map<String, dynamic>);
    }).toList();

    return assignedTasks;
  }

  static Future<Task?> fetchActiveUserTask() async {
    final response = await ApiClient.http.get(ApiEndpoints.getUserActiveTask);

    if (response.statusCode == 200) {
      return Task.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  /// Start work activity log
  static Future<_StartTaskBody> startTask(Task task) async {
    final headers = await LocalHttp.getHeaders();
    final response = await ApiClient.http.post(ApiEndpoints.startTask(task.id),
        headers: headers, hasJsonHeaders: false);

    print("response: ${response.body}");

    if (response.statusCode == 200) {
      return _StartTaskBody.fromJson(jsonDecode(response.body) as Map);
    } else {
      throw "Failed to start task with status code: ${response.statusCode}, body: ${response.body}";
    }
  }

  /// returns true if successfully ended work activity log for this task
  /// TODO; also handle ending of work activity log of other users (by admin) in this function
  static Future<bool> endWorkActivityLog() async {
    final headers = await LocalHttp.getHeaders();
    final response = await ApiClient.http.post(ApiEndpoints.endUserTask,
        headers: headers, hasJsonHeaders: false);

    return response.statusCode == 200;
  }
}

class _StartTaskBody {
  String message;
  AttendanceLog attendanceLog;
  WorkActivityLog workActivityLog;

  _StartTaskBody(this.message, this.attendanceLog, this.workActivityLog);

  factory _StartTaskBody.fromJson(Map json) {
    return _StartTaskBody(
      json["message"],
      AttendanceLog.fromJson(json["attendanceLog"]),
      WorkActivityLog.fromJson(json["workActivityLog"]),
    );
  }
}
