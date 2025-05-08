import 'package:flutter/cupertino.dart';
import 'package:workflow/data/models/task.dart';

@Deprecated("This has been deprecated")
class TaskProvider extends Task with ChangeNotifier {
  TaskProvider() : super.empty();

  void setCurrentTask(Task task) {
    super.replaceWith(task);
  }
}
