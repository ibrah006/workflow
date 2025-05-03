import 'package:workflow/data/models/user.dart';

class Task {
  final int id;
  final String title;
  final String description;
  final DateTime dueDate;

  late final String _status;
  String get status => _status;

  final List<User> assignees;
  final int projectId;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required String status,
    required this.assignees,
    required this.projectId,
  }) {
    status = status.replaceAll(RegExp(r"_"), " ");
    _status = "${status[0].toUpperCase()}${status.substring(1)}";
  }

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'],
        title: json['name'],
        description: json['description'],
        dueDate: DateTime.parse(json['dueDate']),
        // estimatedHours: json['estimatedHours'],
        status: json["status"],
        // TaskStatus.values
        //     .firstWhere((e) => e.toString().split('.').last == json['status']),
        assignees: (json['assignees'] as List).map((assigneeRaw) {
          return User.fromJson(assigneeRaw);
        }).toList(),
        projectId: json['project']['id'],
      );

  Map<String, dynamic> toJson() {
    try {
      return {
        'id': id,
        'name': title,
        'description': description,
        'dueDate': dueDate.toIso8601String(),
        'status': status,
        'assignees': assignees.map((user) => user.toJson()).toList(),
        'project': {'id': projectId},
      };
    } catch (e) {
      print("error caught: $e");
      return {};
    }
  }
}
