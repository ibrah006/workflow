import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  String get todayDisplay => DateFormat('EEE, MMM d').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text("Welcome, Admin"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todayDisplay,
              style: textTheme.bodyLarge!.copyWith(
                  letterSpacing: 0.25, color: Colors.blueGrey.shade800),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Icon(
                        EvaIcons.checkmarkSquare2,
                        color: Color(0xFF72aafe),
                        size: 33,
                      ),
                      SizedBox(height: 5),
                      Text("Active Tasks",
                          style: textTheme.titleMedium!.copyWith(
                              fontSize: textTheme.titleMedium!.fontSize! - 1.5,
                              color: Colors.black.withAlpha(210),
                              fontWeight: FontWeight.w500)),
                      SizedBox(height: 2),
                      Text("12",
                          style: textTheme.titleMedium!
                              .copyWith(color: Colors.black.withAlpha(210)))
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Icon(
                        EvaIcons.cube,
                        color: Color(0xFFabc3d8),
                        size: 33,
                      ),
                      SizedBox(height: 5),
                      Text("Inventory",
                          style: textTheme.titleMedium!.copyWith(
                              fontSize: textTheme.titleMedium!.fontSize! - 1.5,
                              color: Colors.black.withAlpha(210),
                              fontWeight: FontWeight.w500)),
                      SizedBox(height: 2),
                      Text("258",
                          style: textTheme.titleMedium!
                              .copyWith(color: Colors.black.withAlpha(210)))
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Icon(
                        EvaIcons.alertTriangle,
                        color: Color(0xFFff6e52),
                        size: 33,
                      ),
                      SizedBox(height: 5),
                      Text("Wastage",
                          style: textTheme.titleMedium!.copyWith(
                              fontSize: textTheme.titleMedium!.fontSize! - 1.5,
                              color: Colors.black.withAlpha(210),
                              fontWeight: FontWeight.w500)),
                      SizedBox(height: 2),
                      Text("\$1,200",
                          style: textTheme.titleMedium!
                              .copyWith(color: Colors.black.withAlpha(210)))
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            // Wastage trends
            Text(
              "Wastage Trends",
              style: textTheme.titleMedium!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Source",
                        style: textTheme.bodyLarge!
                            .copyWith(color: Colors.blueGrey.shade800),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "Inventory",
                        style: textTheme.bodyLarge!.copyWith(
                            fontSize: textTheme.bodyLarge!.fontSize! + 1.5),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Cost Analysis",
                        style: textTheme.bodyLarge!
                            .copyWith(color: Colors.blueGrey.shade800),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "Past Week",
                        style: textTheme.bodyLarge!.copyWith(
                            fontSize: textTheme.bodyLarge!.fontSize! + 1.5),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: WastageLineChart(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class WastageLineChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final labelsStyleX =
        textTheme.labelLarge!.copyWith(color: Colors.blueGrey.shade600);

    final labelsStyleY = textTheme.labelLarge!.copyWith(
        color: Colors.blueGrey.shade600, fontWeight: FontWeight.normal);

    return AspectRatio(
      aspectRatio: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            titlesData: FlTitlesData(
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 32,
                  interval: 1,
                  getTitlesWidget: (value, _) {
                    switch (value.toInt()) {
                      case 0:
                        return Text('Thu', style: labelsStyleX);
                      case 1:
                        return Text('Fri', style: labelsStyleX);
                      case 2:
                        return Text('Sat', style: labelsStyleX);
                      default:
                        return const SizedBox.shrink();
                    }
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 3,
                  getTitlesWidget: (value, meta) {
                    if (value == 0 || value == 9) {
                      return const SizedBox
                          .shrink(); // Hide origin and max value
                    }
                    return Text(
                      value.toInt().toString(),
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: Colors.blueGrey.shade600),
                    );
                  },
                ),
              ),
            ),
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
            minX: 0,
            maxX: 2,
            minY: 0,
            maxY: 9,
            lineBarsData: [
              LineChartBarData(
                spots: [
                  FlSpot(0, 4),
                  FlSpot(1, 6),
                  FlSpot(2, 3),
                ],
                isCurved: true,
                barWidth: 3,
                color: Color(0xFF6198f8),
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF6198f8).withAlpha(18),
                      Colors.white,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
