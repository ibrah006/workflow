import 'package:flutter/widgets.dart';
import 'package:workflow/data/models/user.dart';

class Task {
  late int _id;
  late String _title;
  late String _description;
  late DateTime _dueDate;

  late String _status;
  late List<User> _assignees;
  late int _projectId;

  DateTime? _dateCompleted;

  Color? _color;
  IconData? _icon;

  // Constructor to initialize values
  Task({
    required int id,
    required String title,
    required String description,
    required DateTime dueDate,
    required String status,
    required List<User> assignees,
    required int projectId,
    required DateTime? dateCompleted,
  })  : _id = id,
        _title = title,
        _description = description,
        _dueDate = dueDate,
        _assignees = assignees,
        _projectId = projectId,
        _dateCompleted = dateCompleted {
    _status = status.replaceAll(RegExp(r"_"), " ");
    _status = "${_status[0].toUpperCase()}${_status.substring(1)}";
  }

  // Getters (you can add more specific access rules here)
  int get id => _id;
  String get title => _title;
  String get description => _description;
  DateTime get dueDate => _dueDate;
  String get status => _status;
  List<User> get assignees => _assignees;
  int get projectId => _projectId;
  DateTime? get dateCompleted => _dateCompleted;
  Color? get color => _color;
  IconData? get icon => _icon;

  // Setters (make sure only Task can modify these)
  set status(String newStatus) {
    _status = newStatus.replaceAll(RegExp(r"_"), " ");
    _status = "${_status[0].toUpperCase()}${_status.substring(1)}";
  }

  set color(Color? newColor) {
    _color = newColor;
  }

  set icon(IconData? newIcon) {
    _icon = newIcon;
  }

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'],
        title: json['name'],
        description: json['description'],
        dueDate: DateTime.parse(json['dueDate']),
        dateCompleted: json['dateCompleted'] != null
            ? DateTime.parse(json['dateCompleted'])
            : null,
        // estimatedHours: json['estimatedHours'],
        status: json["status"],
        // TaskStatus.values
        //     .firstWhere((e) => e.toString().split('.').last == json['status']),
        assignees: (json['assignees'] as List).map((assigneeRaw) {
          return User.fromJson(assigneeRaw);
        }).toList(),
        projectId: json['project']['id'],
      );

  // Copy constructor
  Task.copy(Task original)
      : _id = original.id,
        _title = original.title,
        _description = original.description,
        _dueDate = original.dueDate,
        _assignees = List.from(original.assignees),
        _projectId = original.projectId {
    String status = original._status;
    _status = status;
    color = original.color;
    icon = original.icon;
  }

  // This Constructor serves those classes which inherit or use Task model as property, and have initial or at any point, a pointing to a Task that doesn't exist
  Task.empty();

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

  // `replaceWith` function to update Task attributes
  void replaceWith(Task newTask) {
    _id = newTask._id;
    _title = newTask._title;
    _description = newTask._description;
    _dueDate = newTask._dueDate;
    _status = newTask._status;
    _assignees = List.from(newTask._assignees);
    _projectId = newTask._projectId;
    _color = newTask._color;
    _icon = newTask._icon;
  }
}
