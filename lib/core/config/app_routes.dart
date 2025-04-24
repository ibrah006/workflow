import 'package:flutter/material.dart';
import 'package:workflow/home_screen.dart';
import 'package:workflow/login_screen.dart';

class AppRoutes {
  static const login = "/login";
  static const home = "/home";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (_) {
      switch (settings.name) {
        case login:
          return LoginScreen();
        case home:
          return HomeScreen();
        default:
          return Placeholder();
      }
    });
  }
}
