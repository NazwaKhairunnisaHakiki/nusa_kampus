import 'package:flutter/material.dart';

import '../../data/repositories/schedule_repository.dart';
import '../../data/repositories/task_repository.dart';
import '../../domain/models/course.dart';
import '../../domain/models/task.dart';

class HomeViewModel extends ChangeNotifier {
  final ScheduleRepository _scheduleRepository;
  final TaskRepository _taskRepository;

  HomeViewModel(this._scheduleRepository, this._taskRepository) {
    _taskRepository.addListener(_onTasksChanged);
  }

  bool isLoading = false;
  String? error;

  List<Course> todayCourses = [];
  List<Task> pendingTasks = [];

  void _onTasksChanged() {
    _updatePendingTasks();
    notifyListeners();
  }

  void _updatePendingTasks() {
    pendingTasks = _taskRepository.tasks
        .where((task) => !task.isCompleted)
        .toList();
  }

  Future<void> load() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        _scheduleRepository.getCourses(),
        _taskRepository.getTasks(),
      ]);

      final courses = results[0] as List<Course>;

      final weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];

      final today = DateTime.now().weekday;

      if (today >= 1 && today <= 5) {
        todayCourses = courses
            .where((course) => course.day == weekdays[today - 1])
            .toList();
      } else {
        todayCourses = [];
      }

      _updatePendingTasks();
    } catch (e) {
      error = 'Failed to load home data: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _taskRepository.removeListener(_onTasksChanged);
    super.dispose();
  }
}
