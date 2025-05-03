import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workflow/core/extensions/datetime_conversions_ext.dart';
import 'package:workflow/data/models/task.dart';
import 'package:workflow/core/providers/dashboard_details_provider.dart';
import 'package:workflow/core/components/custom_card.dart';

class ActiveTaskCard extends StatefulWidget {
  final String title;
  final String description;
  final DateTime dueDate;
  final bool isCompleted;

  const ActiveTaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.dueDate,
    this.isCompleted = false,
  });

  @override
  State<ActiveTaskCard> createState() => _ActiveTaskCardState();
}

class _ActiveTaskCardState extends State<ActiveTaskCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1250))
      ..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dashboard = context.watch<DashboardDetailsProvider>();

    late final Task task;
    try {
      task = dashboard.activeWorkActivityLog!.task!;
    } catch (e) {
      throw "Active Task Card is designed to only display active task from provider 'DashboardDetailsProvider', this error is likely thrown if DashboardDetailsProvider.activeWorkActivityLog is null or DashboardDetailsProvider.activeWorkActivityLog.task is null (unhandled yet)";
    }

    final title = task.title;
    final dueDate = task.dueDate.dayDisplay;
    final status = task.status;

    return CustomCard(
      child: Row(
        children: [
          // Animated Icon
          ScaleTransition(
            scale: _pulseAnimation,
            child: Container(
              width: 42,
              height: 42,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFFF3CD),
              ),
              child: const Icon(Icons.build, color: Color(0xFFFFC107)),
            ),
          ),
          const SizedBox(width: 16),

          // Info Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  dueDate,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 6),

                // Animated progress indicator (fake)
                Container(
                  height: 6,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: TweenAnimationBuilder<double>(
                    duration: const Duration(seconds: 2),
                    tween: Tween<double>(begin: 0.4, end: 0.8),
                    curve: Curves.easeInOut,
                    builder: (context, value, _) {
                      return FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: value,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      "Est. Time: N/a",
                      style: const TextStyle(fontSize: 13),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 13,
                        color: status.toLowerCase() == "in progress"
                            ? Colors.blue
                            : Colors.orange,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Button
          GestureDetector(
            // onTap: widget.onTap,
            onTap: endWorkActivityLog,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                "End",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.red.shade700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void endWorkActivityLog() async {
    print("we're right here");
    await context.read<DashboardDetailsProvider>().endUserTask();
  }
}
