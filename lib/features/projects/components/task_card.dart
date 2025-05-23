import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workflow/core/components/border_button.dart';
import 'package:workflow/core/config/app_routes.dart';
import 'package:workflow/core/extensions/datetime_conversions_ext.dart';
import 'package:workflow/data/models/task.dart';

class TaskCard extends StatelessWidget {
  const TaskCard(this.task, {super.key});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final title = task.title;
    final status = task.status;
    final dueDate = DateFormat('MMM dd').format(task.dueDate);

    return BorderButton(
      onPressed: () {
        Navigator.pushNamed(context, AppRoutes.task, arguments: task);
      },
      margin: EdgeInsets.symmetric(horizontal: 20),
      // shadowGreyLevel: 0.08,
      // color: Theme.of(context).scaffoldBackgroundColor,
      // padding: EdgeInsets.all(16),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(12),
      //   border:
      //       Border.all(width: 1.75, color: Color.fromARGB(255, 233, 237, 238)),
      // ),
      child: DefaultTextStyle(
        style: textTheme.bodyLarge!.copyWith(color: Colors.blueGrey.shade900),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Task title
            Text(title,
                style: textTheme.titleMedium!.copyWith(
                    color: Colors.black, fontWeight: FontWeight.w500)),
            SizedBox(height: 5),
            // Assignees
            Row(
              children: [
                CircleAvatar(
                  radius: 12,
                  child: Icon(
                    EvaIcons.person,
                    size: 20,
                  ),
                ),
                Expanded(child: SizedBox()),
                Icon(EvaIcons.archiveOutline, size: 19),
                SizedBox(width: 5),
                Text(status),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                // Due date
                Icon(EvaIcons.calendarOutline, size: 19),
                SizedBox(width: 5),
                Text(dueDate,
                    style: textTheme.bodyMedium!
                        .copyWith(color: task.dueDate.deadlineColor)),
                // TODO: Implement the backend for this
                // TODO: Total time clocked in by users for this task.
                Expanded(child: SizedBox()),
                Text("12h")
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  EvaIcons.alertTriangle,
                  color: Color(0xFFfdc800),
                  size: 19,
                ),
                SizedBox(width: 5),
                Text("Material Wastage",
                    style: textTheme.titleSmall!
                        .copyWith(color: Color(0xFFf7303a))),
                Expanded(child: SizedBox()),
                Icon(EvaIcons.chevronRight,
                    size: 28, color: Colors.blueGrey.shade900)
              ],
            )
          ],
        ),
      ),
    );
  }
}
