import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workflow/core/config/app_routes.dart';
import 'package:workflow/core/extensions/datetime_conversions_ext.dart';
import 'package:workflow/data/models/project.dart';
import 'package:workflow/features/projects/screens/project_screen.dart';

class ProjectOverviewSection extends StatelessWidget {
  const ProjectOverviewSection({super.key, required this.project});

  final Project project;

  String formatDate(DateTime date) {
    return DateFormat('MMM dd').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final tasksProgress = project.completedTasks.length / project.tasks.length;

    final startDate = formatDate(project.dateStarted);
    final dueDate =
        project.dueDate != null ? formatDate(project.dueDate!) : "N/a";

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tasks progress
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Tasks Progress"),
              Text("${(tasksProgress * 100).toInt()}%")
            ],
          ),
          SizedBox(height: 13),
          LinearProgressIndicator(
            minHeight: 10,
            value: tasksProgress,
            borderRadius: BorderRadius.circular(20),
          ),
          SizedBox(height: 15),
          // Start and End Dates
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(2, (index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(["Start Date", "Deadline"][index],
                        style: ProjectScreen.commonTextStyle(textTheme)
                            .copyWith(color: Colors.grey.shade800)),
                    SizedBox(height: 3),
                    Text([startDate, dueDate][index],
                        style:
                            ProjectScreen.commonTextStyle(textTheme).copyWith(
                                fontWeight: FontWeight.w600,
                                color: index == 1
                                    ? /* for Deadline */
                                    project.dueDate?.deadlineColor
                                    : /* for Start Date */
                                    null))
                  ],
                );
              })),

          Divider(
            height: 50,
            color: Color.fromARGB(255, 232, 234, 238),
          ),

          // Assignees
          Text(
            "Assigned To",
            style: textTheme.titleMedium!.copyWith(color: Colors.black),
          ),
          SizedBox(height: 10),
          CircleAvatar(child: Icon(EvaIcons.person, size: 28)),
          SizedBox(height: 20),

          // Description
          Text(
            "Description",
            style: textTheme.titleMedium!.copyWith(color: Colors.black),
          ),
          SizedBox(height: 10),
          Text(project.description ?? "N/a", style: textTheme.bodyLarge),

          Divider(
            height: 55,
            color: Color.fromARGB(255, 232, 234, 238),
          ),

          // Add task button
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.createTask);
                },
                style: FilledButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.5)),
                icon: Icon(
                  EvaIcons.plus,
                  size: 27,
                ),
                label: Text(
                  "Add Task",
                  style: textTheme.titleMedium!.copyWith(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
