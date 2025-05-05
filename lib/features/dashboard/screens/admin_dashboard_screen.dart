import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:workflow/core/components/task_tile.dart';
import 'package:workflow/core/providers/dashboard_details_provider.dart';
import 'package:workflow/data/models/task.dart';
import 'package:workflow/features/dashboard/components/wastage_line_chart.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  String get todayDisplay => DateFormat('EEE, MMM d').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final dashboard = context.watch<DashboardDetailsProvider>();

    final tasks = dashboard.assignedTasks;

    dashboard.init();

    if (!dashboard.initialized) {
      return Container(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome, Admin"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todayDisplay,
              style: textTheme.bodyLarge!.copyWith(
                  letterSpacing: 0.25, color: Colors.blueGrey.shade800),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Icon(
                        EvaIcons.checkmarkSquare2,
                        color: Color(0xFF72aafe),
                        size: 33,
                      ),
                      SizedBox(height: 5),
                      Text("Active Tasks",
                          style: textTheme.titleMedium!.copyWith(
                              fontSize: textTheme.titleMedium!.fontSize! - 1.5,
                              color: Colors.black.withAlpha(210),
                              fontWeight: FontWeight.w500)),
                      SizedBox(height: 2),
                      Text("12",
                          style: textTheme.titleMedium!
                              .copyWith(color: Colors.black.withAlpha(210)))
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Icon(
                        EvaIcons.cube,
                        color: Color(0xFFabc3d8),
                        size: 33,
                      ),
                      SizedBox(height: 5),
                      Text("Inventory",
                          style: textTheme.titleMedium!.copyWith(
                              fontSize: textTheme.titleMedium!.fontSize! - 1.5,
                              color: Colors.black.withAlpha(210),
                              fontWeight: FontWeight.w500)),
                      SizedBox(height: 2),
                      Text("258",
                          style: textTheme.titleMedium!
                              .copyWith(color: Colors.black.withAlpha(210)))
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Icon(
                        EvaIcons.alertTriangle,
                        color: Color(0xFFff6e52),
                        size: 33,
                      ),
                      SizedBox(height: 5),
                      Text("Wastage",
                          style: textTheme.titleMedium!.copyWith(
                              fontSize: textTheme.titleMedium!.fontSize! - 1.5,
                              color: Colors.black.withAlpha(210),
                              fontWeight: FontWeight.w500)),
                      SizedBox(height: 2),
                      Text("\$1,200",
                          style: textTheme.titleMedium!
                              .copyWith(color: Colors.black.withAlpha(210)))
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            // Wastage trends
            Text(
              "Wastage Trends",
              style: textTheme.titleMedium!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Source",
                        style: textTheme.bodyLarge!
                            .copyWith(color: Colors.blueGrey.shade800),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "Inventory",
                        style: textTheme.bodyLarge!.copyWith(
                            fontSize: textTheme.bodyLarge!.fontSize! + 1.5),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Cost Analysis",
                        style: textTheme.bodyLarge!
                            .copyWith(color: Colors.blueGrey.shade800),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "Past Week",
                        style: textTheme.bodyLarge!.copyWith(
                            fontSize: textTheme.bodyLarge!.fontSize! + 1.5),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: WastageLineChart(),
                )
              ],
            ),

            Text(
              "Active Tasks",
              style: textTheme.titleMedium!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 15),

            // Active Tasks list
            ...List.generate(4, (index) {
              final task = Task.copy(tasks[0]);

              task.color = [
                Color(0xFF3b72e3),
                Colors.blueGrey.shade800,
                Color(0xFFff7043),
                Color(0xFFabc3d8)
              ][index];

              task.icon = [
                EvaIcons.fileText,
                EvaIcons.folderRemove,
                EvaIcons.map,
                EvaIcons.cube,
              ][index];

              return TaskTile(task: task);
            }),
            if (tasks.isEmpty)
              Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        EvaIcons.fileOutline,
                        color: Colors.grey.shade400,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Icon(
                          EvaIcons.close,
                          size: 14,
                          color: Colors.grey.shade400,
                        ),
                      )
                    ],
                  ),
                  Text(
                    " There are no active tasks.",
                    style: textTheme.labelLarge!.copyWith(color: Colors.grey),
                  )
                ],
              )
          ],
        ),
      ),
    );
  }
}
