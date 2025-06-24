import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:workflow/core/components/custom_text_field.dart';

class CreateProjectScreen extends StatelessWidget {
  const CreateProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "New Project",
              style: textTheme.headlineMedium,
            ),
            SizedBox(height: 35),
            CustomTextField(
              hintText: "Enter project name",
              label: "Project Name",
            ),
            SizedBox(height: 25),
            CustomTextField(
              hintText: "Start Date",
              label: "Enter start date",
              suffixIcon: EvaIcons.calendarOutline,
            ),
            SizedBox(height: 25),
            CustomTextField(
              hintText: "Department",
              label: "Select Department(s)",
            ),
            SizedBox(height: 25),
            CustomTextField(
              hintText: "Select User",
              label: "Project Head",
            ),
            SizedBox(height: 35),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12)),
                child: Text("Create",
                    style:
                        textTheme.titleMedium!.copyWith(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
