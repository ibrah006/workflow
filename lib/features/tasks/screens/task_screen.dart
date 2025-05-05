import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workflow/core/components/custom_card.dart';
import 'package:workflow/core/extensions/datetime_conversions_ext.dart';
import 'package:workflow/core/providers/task_provider.dart';
import 'package:workflow/data/models/user.dart';

class TaskScreen extends StatefulWidget {
  TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final currentUser = User.currentUser();

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final commonTextStyle = textTheme.titleMedium!
        .copyWith(fontWeight: FontWeight.normal, color: Colors.black);

    final nameStyle =
        commonTextStyle.copyWith(color: textTheme.titleMedium!.color);

    // final

    return Consumer<TaskProvider>(builder: (context, task, child) {
      final title = task.title;
      final status = task.status;
      final dueDate = task.dueDate.dayDisplayRough;

      return Scaffold(
        appBar: AppBar(),
        body: DefaultTextStyle(
          style: commonTextStyle,
          child: Padding(
            padding: EdgeInsets.all(25).copyWith(top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Manage Task", style: textTheme.headlineMedium),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: textTheme.headlineSmall,
                          ),
                          SizedBox(height: 5),
                          Text(
                              "${currentUser.name[0].toUpperCase()}${currentUser.name.substring(1)}",
                              style: nameStyle)
                        ],
                      ),
                    ),
                    CircleAvatar(
                        radius: 30,
                        backgroundColor: task.color,
                        child: Icon(
                          task.icon,
                          size: 37,
                        ))
                  ],
                ),
                SizedBox(height: 30),

                // Status indicator
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                    border: Border.all(
                        width: 1.5, color: Color.fromARGB(255, 227, 232, 233)),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 13, horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Status"),
                      CustomCard(
                        borderRadius: 13,
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                        color: Color.fromARGB(255, 236, 240, 241),
                        child: Text(status),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 35),

                // Material Usage section
                CustomCard(
                  shadowGreyLevel: 0.08,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      // Estimated Materials & Actually Used Materials tabs
                      Padding(
                        padding: const EdgeInsets.all(16).copyWith(bottom: 0),
                        child: Row(
                          spacing: 15,
                          children: List.generate(2, (index) {
                            final child =
                                LayoutBuilder(builder: (context, constraints) {
                              print("width: ${constraints.maxWidth}");

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedTab = index;
                                  });
                                },
                                child: Column(
                                  children: [
                                    Text(
                                        [
                                          "Estimated Materials",
                                          "Used Materials"
                                        ][index],
                                        style: commonTextStyle.copyWith(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w600,
                                            color: selectedTab != index
                                                ? Colors.grey.shade600
                                                : null)),
                                    SizedBox(height: 7),
                                    // Selected Indicator
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      height: 4,
                                      width: selectedTab == index
                                          ? (constraints.maxWidth ==
                                                  double.infinity
                                              ? 112
                                              : constraints.maxWidth)
                                          : 0,
                                      decoration: BoxDecoration(
                                          color: Color(0xFF0e55d6),
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                    )
                                  ],
                                ),
                              );
                            });
                            return index == 0
                                ? Expanded(
                                    child: child,
                                  )
                                : child;
                          }),
                        ),
                      ),
                      SizedBox(height: 5),
                      Divider(
                        color: Color(0xFFf4f6f8),
                      ),
                      // No Material estimation found message
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 40),
                        child: Column(
                          children: [
                            Icon(
                              EvaIcons.alertTriangleOutline,
                              color: Color(0xFFff6e52),
                              size: 43,
                            ),
                            SizedBox(height: 9),
                            Text("No Estimation Added",
                                style: textTheme.titleLarge),
                            SizedBox(height: 14),
                            Text(
                              "Please add estimated materials for wastage calculation",
                              style: textTheme.bodyLarge!
                                  .copyWith(color: Color(0xFF546e83)),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 14),
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                      shape: WidgetStatePropertyAll(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(13)))),
                                  child: Text("Add Estimated Material")),
                            ),
                            SizedBox(height: 14),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
