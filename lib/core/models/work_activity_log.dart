import 'package:workflow/core/models/task.dart';

class WorkActivityLog {
  final int id;
  final String userId;
  final Task? task;
  final DateTime start;
  final DateTime? end;

  WorkActivityLog({
    required this.id,
    required this.userId,
    this.task,
    required this.start,
    this.end,
  });

  factory WorkActivityLog.fromJson(Map<String, dynamic> json) {
    return WorkActivityLog(
      id: json['id'],
      userId: json['user'].id,
      task: Task.fromJson(json['task']),
      // task: json["task"],
      start: DateTime.parse(json['start']),
      end: json['end'] != null ? DateTime.parse(json['end']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': {'id': userId},
      'task': task?.toJson(),
      'start': start.toIso8601String(),
      'end': end?.toIso8601String(),
    };
  }
}
