class LayoffLog {
  final String id;
  final String userId;
  final DateTime start;
  final DateTime? end;
  final String? reason;

  LayoffLog({
    required this.id,
    required this.userId,
    required this.start,
    this.end,
    this.reason,
  });

  factory LayoffLog.fromJson(Map<String, dynamic> json) => LayoffLog(
        id: json['id'],
        userId: json['userId'],
        start: DateTime.parse(json['start']),
        end: json['end'] != null ? DateTime.parse(json['end']) : null,
        reason: json['reason'],
      );
}
