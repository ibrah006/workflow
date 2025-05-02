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
