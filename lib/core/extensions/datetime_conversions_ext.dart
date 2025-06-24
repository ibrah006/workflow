import 'dart:ui';

import 'package:workflow/core/enums/deadline_status.dart';

extension DateTimeRoughExtension on DateTime {
  String get dayDisplayRough {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final thatDay = DateTime(year, month, day);
    final difference = thatDay.difference(today).inDays;

    if (difference == 0) return "Today";
    if (difference == 1) return "Tomorrow";

    final endOfWeek = today.add(Duration(days: 7 - today.weekday)); // Sunday
    final endOfNextWeek = endOfWeek.add(Duration(days: 7));

    if (thatDay.isBefore(endOfWeek)) return "This Week";
    if (thatDay.isBefore(endOfNextWeek)) return "Next Week";

    final endOfMonth =
        DateTime(now.year, now.month + 1, 0); // Last day of this month
    final endOfNextMonth = DateTime(now.year, now.month + 2, 0);

    if (thatDay.isBefore(endOfNextMonth)) {
      return thatDay.isBefore(endOfMonth) ? "This Month" : "Next Month";
    }

    final monthsAhead = (month - now.month) + 12 * (year - now.year);
    if (monthsAhead < 12) return "$monthsAhead months";
    final yearsAhead = (monthsAhead / 12).floor();
    return "$yearsAhead year${yearsAhead > 1 ? 's' : ''}";
  }
}

extension DateTimeDisplayExtension on DateTime {
  String get dayDisplay {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final thatDay = DateTime(year, month, day);
    final difference = thatDay.difference(today).inDays;

    if (difference == 0) return "Today";
    if (difference == 1) return "Tomorrow";
    if (difference > 1 && difference < 7) return "in $difference days";
    if (difference == 7) return "Week";

    return "${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year";
  }
}

extension DateTimeDeadline on DateTime? {
  DeadlineStatus get deadlineStatus {
    if (this != null) {
      final deadlineDueIn = this!.difference(DateTime.now()).inDays;
      return deadlineDueIn >= 0
          ? DeadlineStatus.pending
          : DeadlineStatus.overdue;
    } else {
      return DeadlineStatus.na;
    }
  }
}

extension DatetimeUIExtension on DateTime {
  Color? get deadlineColor {
    switch (deadlineStatus) {
      case DeadlineStatus.overdue:
        return Color(0xFFf7303a);
      case DeadlineStatus.pending:
        return Color(0xFFff6e52);
      case DeadlineStatus.na:
        return null;
    }
  }
}

extension DatetimeAdvancedParse on String {
  DateTime? parseFlexibleDate() {
    final now = DateTime.now();
    final monthMap = {
      'Jan': 1,
      'Feb': 2,
      'Mar': 3,
      'Apr': 4,
      'May': 5,
      'Jun': 6,
      'Jul': 7,
      'Aug': 8,
      'Sep': 9,
      'Oct': 10,
      'Nov': 11,
      'Dec': 12
    };

    // Pattern 1: 2nd May
    final pattern1 = RegExp(r"(\d{1,2})(st|nd|rd|th)?\s+([A-Za-z]{3,9})",
        caseSensitive: false);
    final match1 = pattern1.firstMatch(this);
    if (match1 != null) {
      final day = int.parse(match1.group(1)!);
      final monthStr = match1.group(3)!.substring(0, 3).capitalize();
      final month = monthMap[monthStr];
      return DateTime(now.year, month!, day);
    }

    // Pattern 2: 2 May, 25 or 2 May
    final pattern2 = RegExp(r"(\d{1,2})\s+([A-Za-z]{3,9}),?\s*(\d{2,4})?",
        caseSensitive: false);
    final match2 = pattern2.firstMatch(this);
    if (match2 != null) {
      final day = int.parse(match2.group(1)!);
      final monthStr = match2.group(2)!.substring(0, 3).capitalize();
      final month = monthMap[monthStr];
      var year = match2.group(3);
      final yearInt = year != null
          ? (int.parse(year) < 100 ? 2000 + int.parse(year) : int.parse(year))
          : now.year;
      return DateTime(yearInt, month!, day);
    }

    // Pattern 3: 2/5/2025 or 2/5
    final pattern3 = RegExp(r"(\d{1,2})/(\d{1,2})(?:/(\d{2,4}))?");
    final match3 = pattern3.firstMatch(this);
    if (match3 != null) {
      final day = int.parse(match3.group(1)!);
      final month = int.parse(match3.group(2)!);
      final year = match3.group(3) != null
          ? (int.parse(match3.group(3)!) < 100
              ? 2000 + int.parse(match3.group(3)!)
              : int.parse(match3.group(3)!))
          : now.year;
      return DateTime(year, month, day);
    }

    return null;
  }
}

extension StringCasingExtension on String {
  String capitalize() => this[0].toUpperCase() + substring(1).toLowerCase();
}
