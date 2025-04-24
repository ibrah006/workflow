import 'package:flutter/material.dart';
import 'package:workflow/login_screen.dart';

void main(List<String> args) {
  runApp(WorkflowApp());
}

class WorkflowApp extends StatelessWidget {
  const WorkflowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // primaryColor: Color(0xFF3776e8),
        // color
        colorScheme: ColorScheme(
          brightness: Brightness.light, // You can choose light or dark here
          primary: Colors.indigo, // Main button color
          onPrimary: Colors
              .white, // Text/icons on primary color (White text for buttons)
          secondary: Color(0xFF00bcd4), // Secondary color, you can adjust this
          onSecondary: Colors.black, // Text/icons on secondary color
          error: Colors.red, // Error color, can use red or any color you prefer
          onError:
              Colors.white, // Text/icons on error color (White text for error)
          surface: Colors.white, // Surface background color (e.g., cards)
          onSurface:
              Colors.black, // Text/icons on surface background (Black text)
          background: Colors.grey[50]!, // Background color (light grey)
          onBackground:
              Colors.black, // Text/icons on background color (Black text)
        ),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontSize: 37,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: TextStyle(
            fontSize: 30, // ~80% of large
            fontWeight: FontWeight.w600, // Slightly lighter
          ),
          headlineSmall: TextStyle(
            fontSize: 24, // ~65% of large
            fontWeight: FontWeight.w500,
          ),
          titleLarge: TextStyle(
            fontSize: 24, // ~25% larger than medium
            fontWeight: FontWeight.w700, // Slightly bolder for emphasis
            color: Color(0xFF455763),
          ),
          titleMedium: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            color: Color(0xFF455763),
          ),
          titleSmall: TextStyle(
            fontSize: 16, // ~15% smaller than medium
            fontWeight: FontWeight.w500,
            color: Color(0xFF455763),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            textStyle:
                WidgetStatePropertyAll(Theme.of(context).textTheme.titleMedium),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            textStyle:
                WidgetStatePropertyAll(Theme.of(context).textTheme.titleMedium),
          ),
        ),
      ),
      home: LoginScreen(),
    );
  }
}
