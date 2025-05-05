import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workflow/core/providers/task_provider.dart';
import 'package:workflow/data/models/task.dart';
import 'package:workflow/features/dashboard/screens/admin_dashboard_screen.dart';
import 'package:workflow/features/auth/screens/login_screen.dart';
import 'package:workflow/features/tasks/screens/task_screen.dart';

class AppRoutes {
  static const login = "/login";
  static const workerDashboard = "/dashboard/worker";
  static const task = "/task";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) {
      switch (settings.name) {
        case login:
          return LoginScreen();
        case workerDashboard:
          return AdminDashboardScreen();
        case task:
          print("settings.arguments: ${(settings.arguments as Task).title}");
          context
              .read<TaskProvider>()
              .setCurrentTask(settings.arguments as Task);
          return TaskScreen();
        default:
          return Placeholder();
      }
    });
  }
}
