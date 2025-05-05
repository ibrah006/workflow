import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workflow/core/config/app_routes.dart';
import 'package:workflow/core/providers/dashboard_details_provider.dart';
import 'package:workflow/core/providers/task_provider.dart';
import 'package:workflow/core/services/login_service.dart';

void main(List<String> args) {
  runApp(WorkflowApp());
}

class WorkflowApp extends StatefulWidget {
  const WorkflowApp({super.key});

  @override
  State<WorkflowApp> createState() => _WorkflowAppState();
}

class _WorkflowAppState extends State<WorkflowApp> {
  bool loginCheck = false;
  bool loggedIn = false;

  @override
  Widget build(BuildContext context) {
    if (!loginCheck) {
      return Container(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : const Color.fromARGB(255, 14, 15, 33));
    }

    final initialRoute = loggedIn ? AppRoutes.workerDashboard : AppRoutes.login;

    final scaffoldBackgroundColor = Color(0xFFf7f9fb);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DashboardDetailsProvider()),
        ChangeNotifierProvider(create: (context) => TaskProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              // primaryColor: Color(0xFF3776e8),
              // color
              scaffoldBackgroundColor: scaffoldBackgroundColor,
              appBarTheme:
                  AppBarTheme(backgroundColor: scaffoldBackgroundColor),
              colorScheme: ColorScheme(
                brightness:
                    Brightness.light, // You can choose light or dark here
                // primary: Colors.indigo, // Main button color
                primary: Color(0xFF3b72e3),
                onPrimary: Colors
                    .white, // Text/icons on primary color (White text for buttons)
                secondary:
                    Color(0xFF00bcd4), // Secondary color, you can adjust this
                onSecondary: Colors.black, // Text/icons on secondary color
                error: Colors
                    .red, // Error color, can use red or any color you prefer
                onError: Colors
                    .white, // Text/icons on error color (White text for error)
                surface: Colors.white, // Surface background color (e.g., cards)
                onSurface: Colors
                    .black, // Text/icons on surface background (Black text)
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
                  textStyle: WidgetStatePropertyAll(
                      Theme.of(context).textTheme.titleMedium),
                ),
              ),
              filledButtonTheme: FilledButtonThemeData(
                style: ButtonStyle(
                  textStyle: WidgetStatePropertyAll(
                      Theme.of(context).textTheme.titleMedium),
                ),
              ),
              outlinedButtonTheme: OutlinedButtonThemeData(
                style: ButtonStyle(
                    // shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(12))),
                    side: WidgetStatePropertyAll(
                      BorderSide(
                        width: 1,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    textStyle: WidgetStatePropertyAll(
                        Theme.of(context).textTheme.titleMedium),
                    foregroundColor: WidgetStatePropertyAll(Colors.black)),
              ),
              progressIndicatorTheme: ProgressIndicatorThemeData(
                  linearTrackColor: Colors.grey.shade200)),
          onGenerateRoute: AppRoutes.generateRoute,
          initialRoute: initialRoute),
    );
  }

  @override
  void initState() {
    super.initState();

    LoginService.isLoggedIn().then((isLoggedIn) {
      setState(() {
        loginCheck = true;
        loggedIn = isLoggedIn;
      });
    });
  }
}
