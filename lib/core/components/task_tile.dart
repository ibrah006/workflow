import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:workflow/core/components/custom_card.dart';
import 'package:workflow/core/config/app_routes.dart';
import 'package:workflow/core/extensions/datetime_conversions_ext.dart';
import 'package:workflow/data/models/task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final title = task.title;
    final status = task.status;
    final dueDate = task.dueDate.dayDisplayRough;

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.task, arguments: task);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Row(
          children: [
            Icon(task.icon ?? EvaIcons.fileText, size: 37, color: task.color),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style:
                          textTheme.titleSmall!.copyWith(color: Colors.black)),
                  SizedBox(height: 2),
                  Row(
                    children: [
                      Text("Due $dueDate"),
                      SizedBox(width: 10),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: .9,
                          minHeight: 8.5,
                          color: task.color,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(width: 5),
            CustomCard(
                hasShadow: false,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                color: task.color?.withValues(alpha: .1),
                child: Text(
                  status,
                ))
          ],
        ),
      ),
    );
  }
}
