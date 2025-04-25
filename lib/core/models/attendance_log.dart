class AttendanceLog {
  final String id;
  final String userId;
  final DateTime clockIn;
  final DateTime? clockOut;

  AttendanceLog({
    required this.id,
    required this.userId,
    required this.clockIn,
    this.clockOut,
  });

  factory AttendanceLog.fromJson(Map<String, dynamic> json) => AttendanceLog(
        id: json['id'],
        userId: json['userId'],
        clockIn: DateTime.parse(json['clockIn']),
        clockOut:
            json['clockOut'] != null ? DateTime.parse(json['clockOut']) : null,
      );
}
