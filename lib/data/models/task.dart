import 'package:flutter/widgets.dart';
import 'package:workflow/data/models/material_log.dart';
import 'package:workflow/data/models/user.dart';

class Task {
  late int _id;
  late String _title;
  late String _description;
  late DateTime _dueDate;

  late String _status;
  late List<User> _assignees;
  late int _projectId;

  // Material logs
  late List<MaterialLog> _estimatedMaterials;
  late List<MaterialLog> _usedMaterials;

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
    required List<MaterialLog> estimatedMaterials,
    required List<MaterialLog> usedMaterials,
    required int projectId,
    required DateTime? dateCompleted,
  })  : _id = id,
        _title = title,
        _description = description,
        _dueDate = dueDate,
        _assignees = assignees,
        _projectId = projectId,
        _dateCompleted = dateCompleted,
        _estimatedMaterials = estimatedMaterials,
        _usedMaterials = usedMaterials {
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
  List<MaterialLog> get estimatedMaterials => _estimatedMaterials;
  List<MaterialLog> get usedMaterials => _usedMaterials;

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
      // Material logs
      estimatedMaterials: ((json["materialsEstimated"] ?? []) as List)
          .map((rawMaterialLog) => MaterialLog.fromJson(rawMaterialLog))
          .toList(),
      usedMaterials: ((json["materialsUsed"] ?? []) as List)
          .map((rawMaterialLog) => MaterialLog.fromJson(rawMaterialLog))
          .toList());

  // Copy constructor
  Task.copy(Task original)
      : _id = original.id,
        _title = original.title,
        _description = original.description,
        _dueDate = original.dueDate,
        _assignees = List.from(original.assignees),
        _projectId = original.projectId,
        _dateCompleted = original._dateCompleted,
        _estimatedMaterials = List.from(original._estimatedMaterials),
        _usedMaterials = List.from(original._usedMaterials) {
    String status = original._status;
    _status = status;
    color = original.color;
    icon = original.icon;
  }

  // This Constructor serves those classes which inherit or use Task model as property, and have initial or at any point, a pointing to a Task that doesn't exist (yet)
  Task.empty();

  // Copy With method
  Task copyWithSafe({
    int? id,
    String? title,
    String? description,
    DateTime? dueDate,
    String? status,
    List<User>? assignees,
    int? projectId,
    DateTime? dateCompleted,
    Color? color,
    IconData? icon,
    List<MaterialLog>? estimatedMaterials,
    List<MaterialLog>? usedMaterials,
  }) {
    final Task newTask = Task.empty();

    try {
      newTask._id = id ?? _id;
    } catch (_) {
      if (id != null) newTask._id = id;
    }

    try {
      newTask._title = title ?? _title;
    } catch (_) {
      if (title != null) newTask._title = title;
    }

    try {
      newTask._description = description ?? _description;
    } catch (_) {
      if (description != null) newTask._description = description;
    }

    try {
      newTask._dueDate = dueDate ?? _dueDate;
    } catch (_) {
      if (dueDate != null) newTask._dueDate = dueDate;
    }

    if (status != null) {
      newTask.status = status;
    } else {
      try {
        newTask.status = _status;
      } catch (_) {}
    }

    try {
      newTask._assignees = assignees ?? _assignees;
    } catch (_) {
      if (assignees != null) newTask._assignees = assignees;
    }

    try {
      newTask._projectId = projectId ?? _projectId;
    } catch (_) {
      if (projectId != null) newTask._projectId = projectId;
    }

    newTask._dateCompleted = dateCompleted ?? _dateCompleted;
    newTask._color = color ?? _color;
    newTask._icon = icon ?? _icon;

    try {
      newTask._estimatedMaterials =
          estimatedMaterials ?? List.from(_estimatedMaterials);
    } catch (_) {
      if (estimatedMaterials != null) {
        newTask._estimatedMaterials = estimatedMaterials;
      }
    }

    try {
      newTask._usedMaterials = usedMaterials ?? List.from(_usedMaterials);
    } catch (_) {
      if (usedMaterials != null) {
        newTask._usedMaterials = usedMaterials;
      }
    }

    return newTask;
  }

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
        'dateCompleted': dateCompleted?.toIso8601String(),
        'estimatedMaterials':
            _estimatedMaterials.map((m) => m.toJson()).toList(),
        'usedMaterials': _usedMaterials.map((m) => m.toJson()).toList(),
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
    _dateCompleted = newTask._dateCompleted;
    _color = newTask._color;
    _icon = newTask._icon;
    _estimatedMaterials = List.from(newTask._estimatedMaterials);
    _usedMaterials = List.from(newTask._usedMaterials);
  }
}
