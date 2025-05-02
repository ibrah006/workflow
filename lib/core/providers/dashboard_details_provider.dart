import 'package:flutter/material.dart';
import 'package:workflow/core/models/task.dart';
import 'package:workflow/core/models/work_activity_log.dart';
import 'package:workflow/data/attendance_analysis_data.dart';
import 'package:workflow/data/performance_score.dart';
import 'package:workflow/services/attendance_log_service.dart';
import 'package:workflow/services/performance_service.dart';
import 'package:workflow/services/task_service.dart';
import 'package:workflow/core/enums/log_data_analysis_for.dart';
import 'package:workflow/core/models/attendance_log.dart';
import 'package:workflow/services/work_activity_log_service.dart';

class DashboardDetailsProvider extends ChangeNotifier {
  List<Task> _assignedTasks = [];

  List<Task> get assignedTasks => _assignedTasks;

  late AttendanceAnalysisData attendanceAnalysisData;

  late PerformanceScore performanceScore;

  late AttendanceLog? _activeAttendanceLog;
  AttendanceLog? get activeAttendanceLog => _activeAttendanceLog;
  set activeAttendanceLog(AttendanceLog? log) {
    _activeAttendanceLog = log;
    // if the attendance log is null, likely because the user has clocked out, we want to end the task activity as well
    if (log == null) {
      _activeWorkActivityLog = null;
    }
    notifyListeners();
  }

  late WorkActivityLog? _activeWorkActivityLog;
  WorkActivityLog? get activeWorkActivityLog => _activeWorkActivityLog;

  bool initialized = false;

  Future<void> _initializeAssignedTasks() async {
    _assignedTasks = await TaskService.fetchUserTasks();
  }

  Future<void> _initializeAttendanceHoursToday() async {
    attendanceAnalysisData =
        await AttendanceLogService.fetchAnalysisData(LogAnalysisDataFor.today);
  }

  Future<void> _initializePerformanceSummary() async {
    performanceScore = await PerformanceService.getUserPerformance();
  }

  Future<void> getActiveAttendanceLog() async {
    activeAttendanceLog = await AttendanceLogService.getActiveLog();
  }

  Future<void> getActiveWorkActivityLog() async {
    _activeWorkActivityLog =
        await WorkActivityLogService.fetchActiveWorkActivityLog();
  }

  Future<void> init() async {
    if (!initialized) {
      await _initializeAssignedTasks();
      await _initializeAttendanceHoursToday();
      await _initializePerformanceSummary();
      await getActiveAttendanceLog();
      await getActiveWorkActivityLog();
      initialized = true;
      notifyListeners();
    }
  }

  Future<Task?> get getCurrentTask async {
    return await TaskService.fetchActiveUserTask();
  }

  Future<bool> startTask(Task task) async {
    print("attempting to start task ${task.id}");
    try {
      final startTaskBody = await TaskService.startTask(task);

      print("start task body: ${startTaskBody}");

      _activeWorkActivityLog = startTaskBody.workActivityLog;
      _activeAttendanceLog = startTaskBody.attendanceLog;

      notifyListeners();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> endUserTask() async {
    final isSuccess = await TaskService.endWorkActivityLog();

    if (isSuccess) {
      _activeWorkActivityLog = null;
    }

    notifyListeners();

    return isSuccess;
  }

  Future<bool> clockOut() async {
    final clockedOut = await AttendanceLogService.clockOut();

    if (clockedOut) {
      attendanceAnalysisData.attendanceToday +=
          activeAttendanceLog!.getDuration;
      _activeAttendanceLog = null;
    }

    notifyListeners();

    return clockedOut;
  }
}
