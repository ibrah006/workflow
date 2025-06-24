import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:workflow/core/components/custom_card.dart';

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
              "Recent Designs",
              style: textTheme.titleMedium,
            ),
            SizedBox(height: 15),
            Row(
                spacing: 13,
                children: List.generate(2, (index) {
                  return Expanded(
                    child: CustomCard(
                      hasShadow: false,
                      strokeWidth: 1,
                      padding: EdgeInsets.all(11),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 60,
                            child: Text(
                              [
                                "Storefront banner",
                                "Artwork Approval pending"
                              ][index],
                              style: textTheme.titleMedium!
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                          Text(
                            ["Draft", "Client"][index],
                            style: textTheme.bodyLarge?.copyWith(
                                color: [
                                  Theme.of(context).primaryColor,
                                  Colors.blueGrey.shade600
                                ][index],
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  );
                })),
            SizedBox(height: 10),
            Row(
              spacing: 8,
              children: List.generate(3, (index) {
                return Expanded(
                  child: SizedBox(
                    height: 65,
                    child: FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Color(0xFFf5f9fd),
                          padding: EdgeInsets.symmetric(horizontal: 3)),
                      child: Text(
                          [
                            "Continue Annotating",
                            "Edit Dimensions",
                            "Add Notes or Labels"
                          ][index],
                          textAlign: TextAlign.center,
                          style: textTheme.titleSmall
                              ?.copyWith(color: Colors.black, fontSize: 16)),
                    ),
                  ),
                );
              }),
            ),
            Divider(
              height: 40,
              color: Color(0xFFe9f1f8),
            ),
            Row(
              children: [
                CustomCard(
                  width: 80,
                  hasShadow: false,
                  color: Color(0xFFf5f9fd),
                  padding: EdgeInsets.all(9).copyWith(bottom: 13),
                  child: Column(
                    children: [
                      Text(
                        "JUN",
                        textAlign: TextAlign.center,
                        style: textTheme.titleMedium
                            ?.copyWith(color: Colors.black),
                      ),
                      Text(
                        "23",
                        textAlign: TextAlign.center,
                        style: textTheme.titleLarge?.copyWith(
                            color: Colors.black,
                            height: 0.7,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Draft",
                          style: textTheme.titleMedium
                              ?.copyWith(color: Colors.black)),
                      Text(
                        "Storefront Banner",
                        style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.normal, fontSize: 17),
                      )
                    ],
                  ),
                )
              ],
            ),
            Divider(
              height: 40,
              color: Color(0xFFe9f1f8),
            ),
          ],
        ));
  }
}
