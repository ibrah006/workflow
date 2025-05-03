import 'package:flutter/material.dart';
import 'package:workflow/core/components/custom_card.dart';

class TaskTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String estTime;
  final String status;
  final bool showResume;

  const TaskTile({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.estTime,
    required this.status,
    required this.showResume,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CustomCard(
      margin: EdgeInsets.only(top: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 7.5),
            child: Icon(icon, color: iconColor),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title,
                              style: textTheme.titleMedium!
                                  .copyWith(fontSize: 17, color: Colors.black)),
                          Text(subtitle),
                        ],
                      ),
                    ),
                    if (showResume)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Color(0xFFf2f7fa),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text('Resume', style: textTheme.labelLarge),
                      ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (estTime.isNotEmpty) Text(estTime),
                    const SizedBox(height: 4),
                    if (status.isNotEmpty)
                      Text(
                        status,
                        style: textTheme.bodyMedium!.copyWith(
                            color:
                                status == "Pending" || status == "In Progress"
                                    ? Color(0xFF408ffe)
                                    : null,
                            fontWeight: FontWeight.w500),
                      ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
