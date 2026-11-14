import 'package:flutter/material.dart';

import '../../data/repositories/schedule_repository.dart';
import '../../domain/models/course.dart';

class ScheduleViewModel extends ChangeNotifier {
  final ScheduleRepository _repository;

  ScheduleViewModel(this._repository);

  bool isLoading = false;
  String? error;

  List<Course> courses = [];

  String selectedDay = 'Monday';

  final List<String> weekdays = const [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

  List<Course> get filteredCourses {
    return courses.where((course) => course.day == selectedDay).toList();
  }

  void selectDay(String day) {
    selectedDay = day;
    notifyListeners();
  }

  Future<void> load() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      courses = await _repository.getCourses();
    } catch (e) {
      error = 'Failed to load schedule: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
