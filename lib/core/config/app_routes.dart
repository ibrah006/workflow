import 'package:flutter/material.dart';
import 'package:workflow/worker_dashboard_screen.dart';
import 'package:workflow/login_screen.dart';

class AppRoutes {
  static const login = "/login";
  static const workerDashboard = "/dashboard/worker";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (_) {
      switch (settings.name) {
        case login:
          return LoginScreen();
        case workerDashboard:
          return WorkerDashboardScreen();
        default:
          return Placeholder();
      }
    });
  }
}
