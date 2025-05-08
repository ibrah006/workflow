import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:workflow/core/components/custom_card.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return CustomCard(
      margin: EdgeInsets.symmetric(horizontal: 20),
      shadowGreyLevel: 0.08,
      color: Theme.of(context).scaffoldBackgroundColor,
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
            Text("Design Mockups",
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
                Text("In Progress"),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                // Due date
                Icon(EvaIcons.calendarOutline, size: 19),
                SizedBox(width: 5),
                Text("Feb 23"),
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
