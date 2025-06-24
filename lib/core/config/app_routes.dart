import 'package:flutter/material.dart';
import 'package:workflow/data/models/project.dart';
import 'package:workflow/data/models/task.dart';
import 'package:workflow/features/dashboard/screens/admin_dashboard_screen.dart';
import 'package:workflow/features/auth/screens/login_screen.dart';
import 'package:workflow/features/dashboard/screens/designer_dashboard_screen.dart';
import 'package:workflow/features/dashboard/screens/worker_dashboard_screen.dart';
import 'package:workflow/features/projects/screens/create_project_screen.dart';
import 'package:workflow/features/projects/screens/project_screen.dart';
import 'package:workflow/features/projects/screens/projects_screen.dart';
import 'package:workflow/features/tasks/screens/artwork_measurement_screen.dart';
import 'package:workflow/features/tasks/screens/create_task_screen.dart';
import 'package:workflow/features/tasks/screens/task_screen.dart';

class AppRoutes {
  static const login = "/login";

  static const workerDashboard = "/dashboard/worker";

  static const task = "/task";
  static const createTask = "/task/create";

  static const projects = "/projects";
  static const project = "/project";
  static const createProject = "/project/create";

  static const artworkMeasurement = "/measurement";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) {
      switch (settings.name) {
        case login:
          return LoginScreen();
        case workerDashboard:
          return DesignerDashboardScreen();
        case task:
          return TaskScreen(settings.arguments as Task);
        case createTask:
          return CreateTaskScreen();
        case projects:
          return ProjectsScreen();
        case project:
          return ProjectScreen(settings.arguments as Project);
        case createProject:
          return CreateProjectScreen();
        case artworkMeasurement:
          return ArtworkMeasurementScreen();
        default:
          return Placeholder();
      }
    });
  }
}
