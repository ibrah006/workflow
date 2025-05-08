import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:workflow/core/components/custom_text_field.dart';

class CreateTaskScreen extends StatelessWidget {
  const CreateTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Create Task", style: textTheme.headlineMedium),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Task name", style: textTheme.titleMedium),
            SizedBox(height: 7.0),
            CustomTextField(hintText: "Task name"),
            SizedBox(height: 15.0),
            Text("Color", style: textTheme.titleMedium),
            SizedBox(height: 7.0),
            SizedBox(
              height: 45,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(4, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: CircleAvatar(
                        backgroundColor: [
                          Color(0xFF3b72e3),
                          Colors.blueGrey.shade800,
                          Color(0xFFff7043),
                          Color(0xFFabc3d8)
                        ][index],
                      ),
                    );
                  })),
            ),
            SizedBox(height: 15.0),
            Text("Icon", style: textTheme.titleMedium),
            SizedBox(height: 7.0),
            SizedBox(
              height: 50,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(4, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: IconButton.outlined(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                            minimumSize: Size(50, 50),
                            side:
                                BorderSide(color: Color(0xFFecf0f6), width: 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13.0),
                            ),
                            iconSize: 30,
                            iconColor: Colors.blueGrey.shade800),
                        icon: Icon([
                          EvaIcons.fileText,
                          EvaIcons.folderRemove,
                          EvaIcons.map,
                          EvaIcons.cube,
                        ][index]),
                      ),
                    );
                  })),
            ),
            SizedBox(height: 15.0),
            Text("Assignees", style: textTheme.titleMedium),
            SizedBox(height: 7.0),
            SizedBox(
              height: 45,
              child: ListView(scrollDirection: Axis.horizontal, children: [
                ...List.generate(2, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Container(
                      width: 45,
                      decoration: BoxDecoration(
                          color: Color(0xFFf7f8fa),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Color(0xFFe7eaef))),
                      child: Icon(EvaIcons.person,
                          size: 32, color: Colors.blueGrey.shade800),
                    ),
                  );
                }),
                Container(
                  width: 45,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Color(0xFFe7eaef))),
                  child: Icon(EvaIcons.plus, color: Colors.blueGrey.shade800),
                ),
              ]),
            ),
            SizedBox(height: 15.0),
            CustomTextField(
              hintText: "Search members...",
              icon: EvaIcons.search,
            ),

            // Due date (required field)
            SizedBox(height: 15.0),
            Text("Due date", style: textTheme.titleMedium),
            SizedBox(height: 7.0),
            CustomTextField(
              hintText: "Due date",
              icon: EvaIcons.calendarOutline,
            ),
          ],
        ),
      ),
    );
  }
}
