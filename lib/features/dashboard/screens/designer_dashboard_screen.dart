import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:workflow/core/components/border_button.dart';
import 'package:workflow/core/components/custom_card.dart';
import 'package:workflow/core/config/app_routes.dart';

class DesignerDashboardScreen extends StatelessWidget {
  const DesignerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Dashboard"),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(EvaIcons.bellOutline))
          ],
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15),
          children: [
            SizedBox(height: 20),
            Row(
              spacing: 10,
              children: List.generate(3, (index) {
                return Expanded(
                  child: CustomCard(
                    hasShadow: false,
                    strokeWidth: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(["Tasks", "Due Today", "Feedback"][index],
                            style: textTheme.bodyLarge),
                        Text(
                          "12",
                          style: textTheme.displaySmall
                              ?.copyWith(fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                );
              }),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
                spacing: 10,
                children: List.generate(
                    2,
                    (index) => Expanded(
                          child: FilledButton.icon(
                            onPressed: () {},
                            style: FilledButton.styleFrom(
                                foregroundColor:
                                    index == 0 ? Colors.black : null,
                                backgroundColor:
                                    index == 0 ? Color(0xFFf5f9fd) : null,
                                padding: EdgeInsets.symmetric(vertical: 11)),
                            icon: Icon(
                              [EvaIcons.uploadOutline, EvaIcons.plus][index],
                              size: 40,
                            ),
                            label: Text(["Upload Artwork", "New Design"][index],
                                style: TextStyle(fontSize: 17)),
                          ),
                        ))),
            SizedBox(height: 20),
            Text(
              "Your Designs",
              style: textTheme.titleMedium,
            ),

            // Task cards
            BorderButton(
                margin: EdgeInsets.only(top: 12),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.designTask);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5,
                  children: [
                    Text("Marketing Website",
                        style: textTheme.titleMedium
                            ?.copyWith(color: Colors.black)),
                    CustomCard(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                      borderRadius: 10,
                      hasShadow: false,
                      color: Colors.grey.shade200,
                      child: Text("High", style: textTheme.bodyMedium),
                    ),
                    Text("Implement responsive landing page",
                        style: textTheme.bodyLarge
                            ?.copyWith(color: Colors.grey.shade800))
                  ],
                ))
          ],
        ));
  }
}
