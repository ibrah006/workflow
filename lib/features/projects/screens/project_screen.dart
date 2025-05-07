import 'package:flutter/material.dart';

import 'package:workflow/core/components/custom_tabs.dart';
import 'package:workflow/data/models/project.dart';
import 'package:workflow/features/projects/sections/project_overview_section.dart';
import 'package:workflow/features/projects/sections/project_tasks_section.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen(this.project, {super.key});

  final Project project;

  static TextStyle commonTextStyle(TextTheme textTheme) =>
      textTheme.titleSmall!.copyWith(
          fontWeight: FontWeight.normal,
          color: Colors.black,
          fontSize: textTheme.titleSmall!.fontSize! + 2);

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  int selectedTab = 0;

  Widget get tabContent {
    switch (selectedTab) {
      case 0:
        return ProjectOverviewSection(project: widget.project);
      case 1:
        return ProjectTasksSection(project: widget.project);
      default:
        return Placeholder();
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      appBar: AppBar(
        centerTitle: false,
        title: Text(widget.project.name,
            style: textTheme.headlineSmall!
                .copyWith(overflow: TextOverflow.ellipsis)),
      ),
      body: DefaultTextStyle(
        style: ProjectScreen.commonTextStyle(textTheme),
        child: Column(
          children: [
            CustomTabs(
                hasTabBorder: true,
                selectedTab: selectedTab,
                tabLabels: {"Overview": 1, "Tasks": 1},
                onPressed: (tabIndex) {
                  setState(() {
                    selectedTab = tabIndex;
                  });
                }),
            SizedBox(height: 10),

            // Selected Tab Content
            tabContent
          ],
        ),
      ),
    );
  }
}
