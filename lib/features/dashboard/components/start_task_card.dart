import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workflow/features/dashboard/components/active_task_card.dart';
import 'package:workflow/core/extensions/datetime_conversions_ext.dart';
import 'package:workflow/data/models/task.dart';
import 'package:workflow/core/providers/dashboard_details_provider.dart';
import 'package:workflow/core/components/custom_card.dart';

class StartTaskCard extends StatelessWidget {
  StartTaskCard({super.key});

  static const _paddingValue = 20.0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final dashboard = context.watch<DashboardDetailsProvider>();

    final isTaskActive = dashboard.activeWorkActivityLog != null;

    print("active work activity log: ${dashboard.activeWorkActivityLog}");

    return isTaskActive
        ? ActiveTaskCard(
            title: "Fix Plumbing work",
            description: "PTask description",
            dueDate: DateTime(2025, 6, 20),
          )
        : CustomCard(
            onPressed: () => showTaskList(context),
            hasShadow: false,
            // color: Color(0xFFf3f8fa),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                        radius: 13, backgroundColor: Color(0xFF054165)),
                    Icon(
                      Icons.play_circle_fill_rounded,
                      size: 38,
                      color: Color(0xFFe4f0fa),
                    ),
                  ],
                ),
                SizedBox(width: 8),
                Text('Start Task',
                    style:
                        textTheme.titleMedium!.copyWith(color: Colors.black)),
              ],
            ),
          );
  }

  int? selectedTaskIndex;

  Widget taskTile({
    required Task task,
    required BuildContext context,
    required int index,
    required setState,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        setState(() {
          selectedTaskIndex = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border:
              Border(top: BorderSide(color: Colors.grey.shade300, width: .65)),
        ),
        padding: const EdgeInsets.all(_paddingValue),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                    backgroundColor: [
                      Color(0xFFfede60),
                      Color(0xFF73d179),
                      Color(0xFF63a2fc)
                    ][Random().nextInt(2)],
                    radius: 13),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 21,
                            fontWeight: FontWeight.w500),
                      ),
                      Text("Due ${task.dueDate.dayDisplay}",
                          style: textTheme.bodyLarge!.copyWith(
                              color: Color(0xFF49585a), letterSpacing: 0)),
                    ],
                  ),
                )
              ],
            ),
            AnimatedContainer(
              height: selectedTaskIndex == index ? 40 : 0,
              duration: Duration(milliseconds: 200),
              width: double.infinity,
              child: FilledButton(
                onPressed: () async {
                  // Start task
                  await context
                      .read<DashboardDetailsProvider>()
                      .startTask(task);
                },
                child: Text("Start Task"),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showTaskList(context) {
    // Show a list of active assigned tasks to the user

    showCupertinoModalPopup(
      context: context,
      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      builder: (context) {
        final textTheme = Theme.of(context).textTheme;

        return Consumer<DashboardDetailsProvider>(
            builder: (context, dashboard, child) {
          final tasks = dashboard.assignedTasks;

          return StatefulBuilder(builder: (context, setState) {
            return Material(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 11,
                    width: 55,
                    margin: EdgeInsets.only(top: _paddingValue),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: _paddingValue),
                          child: Text("Task List",
                              style: textTheme.headlineMedium),
                        ),
                        SizedBox(height: 15),
                        ...List.generate(
                            tasks.length,
                            (index) => taskTile(
                                context: context,
                                index: index,
                                setState: setState,
                                task: tasks[index])),
                        SizedBox(height: 30),
                      ],
                    ),
                  )
                ],
              ),
            );
          });
        });
      },
    );

    // showModalBottomSheet(
    //   context: context,
    //   shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.vertical(top: Radius.circular(0))),
    //   backgroundColor: Colors.white,
    //   builder:
    // );
  }
}
