import 'package:flutter/foundation.dart';
import 'package:workflow/core/services/project_service.dart';
import 'package:workflow/data/models/project.dart';

class ProjectsProvider extends ChangeNotifier {
  List<Project> _projects = [];

  List<Project> get projects => _projects;

  Future<void> initializeProjects() async {
    _projects = await ProjectService.fetchProjects();
  }
}
