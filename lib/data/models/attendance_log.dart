class AttendanceLog {
  final int id;
  final String userId;
  final DateTime clockIn;
  final DateTime? clockOut;

  AttendanceLog({
    required this.id,
    required this.userId,
    required this.clockIn,
    this.clockOut,
  });

  Duration get getDuration {
    return (clockOut ?? DateTime.now()).difference(clockIn);
  }

  factory AttendanceLog.fromJson(Map<String, dynamic> json) {
    print("attendance from json: ${json}");
    return AttendanceLog(
      id: json['id'],
      userId: json['userId'],
      clockIn: DateTime.parse(json['checkIn']),
      clockOut:
          json['clockOut'] != null ? DateTime.parse(json['clockOut']) : null,
    );
  }
}
