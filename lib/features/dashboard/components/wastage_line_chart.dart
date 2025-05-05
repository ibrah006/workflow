import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WastageLineChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final labelsStyleX =
        textTheme.labelLarge!.copyWith(color: Colors.blueGrey.shade600);

    // final labelsStyleY = textTheme.labelLarge!.copyWith(
    //     color: Colors.blueGrey.shade600, fontWeight: FontWeight.normal);

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
                  FlSpot(0, 3),
                  FlSpot(0.5, 4),
                  FlSpot(1, 2),
                  FlSpot(1.5, 6),
                  FlSpot(2, 8),
                ],
                isCurved: true,
                barWidth: 3,
                color: Color(0xFF6198f8),
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF6198f8).withValues(alpha: .07),
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
