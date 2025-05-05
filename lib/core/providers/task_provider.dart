import 'package:flutter/cupertino.dart';
import 'package:workflow/data/models/task.dart';

class TaskProvider extends Task with ChangeNotifier {
  TaskProvider() : super.empty();

  void setCurrentTask(Task task) {
    super.replaceWith(task);
  }
}
