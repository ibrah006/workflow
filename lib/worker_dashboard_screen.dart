import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';
import 'package:workflow/custom_card.dart';
import 'package:workflow/task_tile.dart';

class WorkerDashboardScreen extends StatelessWidget {
  const WorkerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
                          Text('Assigned 4', style: textTheme.titleSmall),
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
                          Text('5h 12m', style: textTheme.titleLarge),
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
                children: [
                  Expanded(
                    child: CustomCard(
                      hasShadow: false,
                      color: Color(0xFFf3f8fa),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                  radius: 13,
                                  backgroundColor: Color(0xFF054165)),
                              Icon(
                                Icons.play_circle_fill_rounded,
                                size: 38,
                                color: Color(0xFFe4f0fa),
                              ),
                            ],
                          ),
                          SizedBox(width: 8),
                          Text('Start Task',
                              style: textTheme.titleMedium!
                                  .copyWith(color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomCard(
                      color: Color(0xFFf3f8fa),
                      alignment: Alignment.center,
                      hasShadow: false,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                radius: 17,
                                backgroundColor: Color(0xFFe4f0fa),
                              ),
                              Icon(Icons.fiber_manual_record,
                                  color: Color(0xFF054165), size: 18),
                            ],
                          ),
                          SizedBox(width: 8),
                          Text('Clock In',
                              style: textTheme.titleMedium!
                                  .copyWith(color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Assigned Tasks
              Text('Your Assigned Tasks',
                  style: textTheme.titleMedium!.copyWith(color: Colors.black)),
              const SizedBox(height: 12),
              TaskTile(
                icon: Icons.lightbulb,
                iconColor: Colors.orange,
                title: 'Fix Plumbing on Floor 2',
                subtitle: 'Due Today, 3:00 PM',
                estTime: 'Est. Time: 3 h',
                status: 'In Progress',
                showResume: true,
              ),
              const SizedBox(height: 12),
              TaskTile(
                icon: Icons.check_circle,
                iconColor: Colors.green,
                title: 'Material Sorting – Warehouse',
                subtitle: 'Due Tomorrow',
                estTime: '',
                status: 'Pending',
                showResume: false,
              ),

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
                      percent: 0.86,
                      center: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("86%",
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
                      progressColor: Color(0xFF4090ff),
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
}
