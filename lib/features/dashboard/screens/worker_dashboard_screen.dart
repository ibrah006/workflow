import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';
import 'package:workflow/features/dashboard/components/clock_in_card.dart';
import 'package:workflow/core/extensions/duration_conversions_extension.dart';
import 'package:workflow/core/providers/dashboard_details_provider.dart';
import 'package:workflow/core/components/custom_card.dart';
import 'package:workflow/features/dashboard/components/start_task_card.dart';
import 'package:workflow/simple_task_tile.dart';
import 'package:provider/provider.dart';

class WorkerDashboardScreen extends StatefulWidget {
  const WorkerDashboardScreen({super.key});

  @override
  State<WorkerDashboardScreen> createState() => _WorkerDashboardScreenState();
}

class _WorkerDashboardScreenState extends State<WorkerDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final dashboard = context.watch<DashboardDetailsProvider>();

    dashboard.init();

    if (!dashboard.initialized) {
      return Container(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white);
    }

    final tasksAssigned = dashboard.assignedTasks.length;
    print("tasks: ${tasksAssigned}");

    final attendanceToday = dashboard.attendanceAnalysisData.attendanceToday;

    final performancePercent = dashboard.performanceScore.productivityScore;

    final isTaskActive = dashboard.activeWorkActivityLog != null;

    print("performance percent: ${performancePercent}%");

    // Your assigned tasks
    // Number of tasks to be displayed in this dashboard
    final numTasksToDisplay = tasksAssigned > 2 ? 2 : tasksAssigned;

    return Scaffold(
      backgroundColor: const Color(0xFFf9fcfd),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 24,
                        child: Icon(CupertinoIcons.person),
                        // backgroundImage: NetworkImage(
                        //   // 'https://via.placeholder.com/150',
                        // ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Welcome!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Icon(Icons.notifications_none)
                ],
              ),
              const SizedBox(height: 24),

              // Task & Hours Summary
              Row(
                children: [
                  Expanded(
                    child: CustomCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 12.5,
                                    backgroundColor: Color(0xFF337bb8),
                                  ),
                                  Icon(
                                      CupertinoIcons.arrow_up_right_circle_fill,
                                      size: 25,
                                      color: Color(0xFFeaf3f9)),
                                ],
                              ),
                              SizedBox(width: 8),
                              Text('Tasks',
                                  style: textTheme.titleMedium!
                                      .copyWith(color: Colors.black)),
                            ],
                          ),
                          SizedBox(height: 12.5),
                          Text('Assigned $tasksAssigned',
                              style: textTheme.titleSmall),
                          SizedBox(height: 4),
                          Text('Pending 1', style: textTheme.titleSmall),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.access_time, color: Colors.black),
                              SizedBox(width: 8),
                              Text('Hours Today',
                                  style: textTheme.titleMedium!
                                      .copyWith(color: Colors.black)),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(attendanceToday.displayHHMM(),
                              style: textTheme.titleLarge), // 5h 12m
                          SizedBox(height: 3),
                          Text('Clocked In', style: textTheme.titleSmall),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Start Task & Clock In
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: StartTaskCard(),
                  ),
                  if (!isTaskActive) ...[
                    const SizedBox(width: 12),
                    Expanded(child: ClockInCard()),
                  ]
                ],
              ),
              const SizedBox(height: 24),

              // Assigned Tasks
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Your Assigned Tasks',
                      style:
                          textTheme.titleMedium!.copyWith(color: Colors.black)),
                  if (tasksAssigned > 2)
                    TextButton.icon(
                      onPressed: () {},
                      label: Icon(Icons.chevron_right_rounded),
                      icon: Text("View more"),
                    )
                ],
              ),
              ...List.generate(numTasksToDisplay, (index) {
                final task = dashboard.assignedTasks[index];
                return SimpleTaskTile(
                  icon: Icons.lightbulb,
                  iconColor: Colors.orange,
                  title: task.title,
                  subtitle: task.description,
                  estTime: 'No est.',
                  status: task.status,
                  showResume: true,
                );
              }),

              const SizedBox(height: 24),

              // My Performance
              Text('My Performance',
                  style: textTheme.titleMedium!.copyWith(color: Colors.black)),
              const SizedBox(height: 12),
              CustomCard(
                child: Row(
                  children: [
                    CircularPercentIndicator(
                      radius: 55,
                      lineWidth: 6,
                      percent: performancePercent >= 100
                          ? 1
                          : performancePercent / 100,
                      center: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${performancePercent.toInt()}%",
                              style: textTheme.headlineMedium!
                                  .copyWith(color: Color(0xFF1b2933))),
                          Text(
                            "Performance score",
                            style: textTheme.bodySmall,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                      backgroundColor: Color(0xFFebf4fb),
                      progressColor: performancePercent >= 100
                          ? Color(0xFF00C853)
                          : Color(0xFF4090ff),
                    ),
                    const SizedBox(width: 25),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '“Fixing delay on Site B – issue with inventory”',
                            style: textTheme.titleSmall!.copyWith(
                                color: Color(0xFF3a5265),
                                fontStyle: FontStyle.italic),
                          ),
                          SizedBox(height: 6),
                          Text('Project Incharge',
                              style: textTheme.titleSmall!
                                  .copyWith(color: Color(0xFF3a5265))),
                          Text(
                            '3 unread messages',
                            style: textTheme.titleSmall!
                                .copyWith(color: Color(0xFF3a5265)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
}
