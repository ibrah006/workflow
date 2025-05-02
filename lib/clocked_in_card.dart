import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:workflow/core/extensions/duration_conversions_extension.dart';
import 'package:workflow/core/providers/dashboard_details_provider.dart';
import 'package:workflow/custom_card.dart';

class ClockedInCard extends StatefulWidget {
  const ClockedInCard({
    super.key,
  });

  @override
  State<ClockedInCard> createState() => _ClockedInCardState();
}

class _ClockedInCardState extends State<ClockedInCard> {
  late Timer timer;

  bool isLoading = false;

  void showSimpleDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (cont) {
        final textTheme = Theme.of(cont).textTheme;

        return StatefulBuilder(builder: (cont, setState) {
          void clockOut() async {
            setState(() {
              isLoading = true;
            });
            // await Future.delayed(Duration(seconds: 2));
            final clockedOut =
                await context.read<DashboardDetailsProvider>().clockOut();

            setState(() {
              isLoading = false;
            });

            if (clockedOut) {
              Navigator.pop(cont);
            } else {
              // TODO: show some feedback that clock out has failed
            }
          }

          return Dialog(
            child: Container(
              // width: 225,
              padding: EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic, // Add this line
                    children: [
                      Text("Clock Out",
                          style: textTheme.titleMedium!.copyWith(
                              color: Colors.black,
                              fontSize: 26,
                              letterSpacing: -0.5)),
                      IconButton(
                        style: ButtonStyle(
                            padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            minimumSize: WidgetStatePropertyAll(Size.zero)),
                        onPressed: isLoading
                            ? null
                            : () {
                                Navigator.pop(cont);
                              },
                        icon: Icon(
                          Icons.close_rounded,
                          color: Colors.grey.shade500,
                          size: 33,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 13),
                  Text(
                    "Are you sure you want to clock out?",
                    style: TextStyle(fontSize: 18, letterSpacing: 0),
                  ),
                  SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                          child: OutlinedButton(
                              onPressed: isLoading
                                  ? null
                                  : () {
                                      Navigator.pop(cont);
                                    },
                              child: Text("Cancel"))),
                      SizedBox(width: 10),
                      Expanded(
                          child: FilledButton(
                              onPressed: isLoading ? null : clockOut,
                              style: ButtonStyle(
                                  padding: WidgetStatePropertyAll(
                                      EdgeInsets.all(0))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (isLoading) ...[
                                    SizedBox(
                                      width: 10,
                                      height: 10,
                                      child: CircularProgressIndicator(
                                          color: Colors.white),
                                    ),
                                    SizedBox(width: 10),
                                  ],
                                  Text(isLoading ? "Clocking Out" : "Clock Out",
                                      style: isLoading
                                          ? TextStyle(fontSize: 13)
                                          : null),
                                ],
                              )))
                    ],
                  )
                ],
              ),
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textTheme = theme.textTheme;

    final dashboard = context.watch<DashboardDetailsProvider>();

    final displayDuration = dashboard.activeAttendanceLog?.getDuration;

    return CustomCard(
        child: Column(
      children: [
        Text(
          "Clocked In",
          style: textTheme.titleMedium!.copyWith(color: Colors.black),
        ),
        SizedBox(height: 7),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic, // Add this line
          children: [
            Text(
              displayDuration != null
                  ? "${displayDuration.display()}".substring(0, 6)
                  : "00:00:",
              style: textTheme.headlineLarge,
            ),
            SizedBox(
              width: 40,
              child: Text(
                displayDuration?.display().substring(6) ?? "00",
                style: textTheme.headlineMedium!
                    .copyWith(color: Colors.grey.shade600),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        FilledButton(
            onPressed: showSimpleDialog,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.access_time_rounded,
                  color: Colors.white,
                  size: 25,
                ),
                SizedBox(width: 7),
                Text(
                  "End",
                  style: textTheme.titleMedium!.copyWith(color: Colors.white),
                ),
              ],
            ))
      ],
    ));
  }

  @override
  void initState() {
    super.initState();

    // Set up a periodic timer to update every second
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {}); // Triggers UI rebuild
    });
  }

  @override
  void dispose() {
    super.dispose();

    timer.cancel();
  }
}
