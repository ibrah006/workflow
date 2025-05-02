class AttendanceAnalysisData {
  Duration attendanceToday;

  AttendanceAnalysisData({required this.attendanceToday});

  factory AttendanceAnalysisData.fromJson(Map<String, dynamic> json) {
    print("attendance in seconds duration: ${json["attendanceInSeconds"]}");
    return AttendanceAnalysisData(
        attendanceToday: Duration(
            milliseconds:
                (double.parse((json["attendanceInSeconds"] ?? "0").toString()) *
                        1000)
                    .toInt()));
  }
}
