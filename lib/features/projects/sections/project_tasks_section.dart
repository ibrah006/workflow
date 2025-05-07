import 'package:flutter/material.dart';
import 'package:workflow/data/models/project.dart';
import 'package:workflow/features/projects/components/task_card.dart';

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
                  return TaskCard();
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
