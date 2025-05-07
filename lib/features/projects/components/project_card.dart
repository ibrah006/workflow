import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:workflow/core/components/border_button.dart';
import 'package:workflow/core/components/custom_card.dart';
import 'package:workflow/core/config/app_routes.dart';
import 'package:workflow/core/extensions/datetime_conversions_ext.dart';
import 'package:workflow/data/models/project.dart';

class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard(this.project, {super.key});

  Widget tagCard(context, {required String labelText, required Color color}) {
    return CustomCard(
        borderRadius: 11,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
        hasShadow: false,
        color: color.withValues(alpha: .05),
        child: Text(labelText,
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: color)));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final textButtonStyle = Theme.of(context).textButtonTheme.style!.copyWith(
        foregroundColor: WidgetStatePropertyAll(Colors.black),
        overlayColor:
            WidgetStatePropertyAll(Colors.black.withValues(alpha: .04)),
        padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 0, vertical: 5)),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: WidgetStatePropertyAll(Size.zero),
        shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))));

    // Project Details
    final title = project.name;
    final status =
        "${project.status[0].toUpperCase()}${project.status.substring(1)}";
    final assignees = project.assignees;
    final assigneeCount =
        '${assignees.isEmpty ? 'No' : assignees.length} ${assignees.length == 1 ? 'Member' : 'Members'}';
    // final priority = project.pro;
    final taskProgress = project.completedTasks.length / project.tasks.length;
    final dueDate = project.dueDate?.dayDisplay;

    return BorderButton(
      onPressed: () {
        Navigator.pushNamed(context, AppRoutes.project, arguments: project);
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: textTheme.titleMedium!.copyWith(color: Colors.black)),
              // Project status
              tagCard(context, labelText: status, color: Color(0xFF3b72e3))
            ],
          ),
          SizedBox(height: 13),
          Row(
            children: [
              CircleAvatar(
                radius: 15,
                child: Icon(EvaIcons.person),
              ),
              SizedBox(width: 15),
              Text(assigneeCount, style: textTheme.bodyLarge),
              Expanded(child: SizedBox()),
              // Project Priority
              tagCard(context, labelText: "High", color: Colors.red.shade900)
            ],
          ),
          SizedBox(height: 16),
          LinearProgressIndicator(
            value: taskProgress,
            borderRadius: BorderRadius.circular(20),
            minHeight: 10,
          ),
          SizedBox(height: 13),
          Row(
            children: [
              Text("Tasks progress: "),
              Text("${(taskProgress * 100).toInt()}%",
                  style: textTheme.labelLarge!
                      .copyWith(fontWeight: FontWeight.w600)),
              Expanded(child: SizedBox()),
              Text("Deadline: $dueDate")
            ],
          ),
          SizedBox(height: 5),
          TextButtonTheme(
            data: TextButtonThemeData(style: textButtonStyle),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: Icon(EvaIcons.plus),
                    label: Text("Add Task"),
                  ),
                ),
                Container(color: Color(0xFFeef5fc), width: 2, height: 18),
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: Icon(EvaIcons.barChart),
                    label: Text("View Summary"),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
