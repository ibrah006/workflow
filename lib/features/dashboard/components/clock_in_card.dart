import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:workflow/features/dashboard/components/clocked_in_card.dart';
import 'package:workflow/core/providers/dashboard_details_provider.dart';
import 'package:workflow/core/components/custom_card.dart';
import 'package:workflow/core/services/attendance_log_service.dart';

class ClockInCard extends StatefulWidget {
  const ClockInCard({super.key});

  @override
  State<ClockInCard> createState() => _ClockInCardState();
}

class _ClockInCardState extends State<ClockInCard> {
  bool isLoading = false;

  bool clockedIn = true;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final dashboard = context.watch<DashboardDetailsProvider>();

    if (!isLoading) {
      clockedIn = dashboard.activeAttendanceLog != null;
      print(
          "dashboard active attendance log: ${dashboard.activeAttendanceLog}");
    }

    return clockedIn
        ? ClockedInCard()
        : CustomCard(
            onPressed: () async {
              print("clock in check");
              if (!clockedIn) {
                print("clocked in");
                setState(() {
                  isLoading = true;
                });
                // Start clock
                dashboard.activeAttendanceLog =
                    await AttendanceLogService.clockIn();

                print(
                    "dashboard active attendance log: ${dashboard.activeAttendanceLog}");

                setState(() {
                  isLoading = false;
                  clockedIn = true;
                });
              }
            },
            // color: Color(0xFFf3f8fa),
            alignment: Alignment.center,
            hasShadow: false,
            child: isLoading
                ? Lottie.asset(
                    'assets/animations/first_half.json',
                    width: 150,
                    height: 150,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 17,
                            backgroundColor: Color(0xFFe4f0fa),
                          ),
                          Icon(Icons.fiber_manual_record,
                              color: Color(0xFF054165), size: 18),
                        ],
                      ),
                      SizedBox(width: 8),
                      Text('Clock In',
                          style: textTheme.titleMedium!
                              .copyWith(color: Colors.black)),
                    ],
                  ),
          );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    clockedIn =
        context.read<DashboardDetailsProvider>().activeAttendanceLog != null;
  }
}
