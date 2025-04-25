import 'package:workflow/core/enums/task_status.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final int estimatedHours;
  final TaskStatus status;
  final String assignedToUserId;
  final String projectId;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.estimatedHours,
    required this.status,
    required this.assignedToUserId,
    required this.projectId,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        dueDate: DateTime.parse(json['dueDate']),
        estimatedHours: json['estimatedHours'],
        status: TaskStatus.values
            .firstWhere((e) => e.toString().split('.').last == json['status']),
        assignedToUserId: json['assignedToUserId'],
        projectId: json['projectId'],
      );
}
