import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:workflow/data/models/project.dart';

class ProjectTasksSection extends StatelessWidget {
  const ProjectTasksSection({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final screenWidth = MediaQuery.of(context).size.width;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            Row(
                spacing: 25,
                children:
                    List.generate(project.uniqueTaskStatuses.length, (index) {
                  return GestureDetector(
                    child: Container(
                      child: Text(project.uniqueTaskStatuses.elementAt(index),
                          style: textTheme.bodyLarge!
                              .copyWith(color: Colors.grey.shade800)),
                    ),
                  );
                })),
            SizedBox(height: 15),
            Expanded(
              // height: MediaQuery.of(context).size.height / 1.4,
              // height: 400,
              child: GridView.count(
                crossAxisCount: screenWidth > 530 ? 2 : 1, // 2 columns
                // padding: const EdgeInsets.all(16.0),
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: screenWidth > 530 ? 1.05 : 2.25,
                children: List.generate(6, (index) {
                  return Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          width: 1.75,
                          color: Color.fromARGB(255, 233, 237, 238)),
                    ),
                    child: DefaultTextStyle(
                      style: textTheme.bodyLarge!
                          .copyWith(color: Colors.blueGrey.shade900),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Task title
                          Text("Design Mockups",
                              style: textTheme.titleMedium!.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
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
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
