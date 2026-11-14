import 'package:flutter/material.dart';

import '../../domain/models/task.dart';
import '../services/campus_service.dart';

class TaskRepository extends ChangeNotifier {
  final CampusService _service;

  List<Task> _tasks = [];
  bool _isLoaded = false;

  TaskRepository(this._service);

  List<Task> get tasks => List.unmodifiable(_tasks);

  Future<List<Task>> getTasks() async {
    if (!_isLoaded) {
      _tasks = await _service.fetchTasks();
      _isLoaded = true;
      notifyListeners();
    }

    return tasks;
  }

  Future<void> toggleTask(String id, bool isCompleted) async {
    await getTasks();

    _tasks = _tasks.map((task) {
      if (task.id == id) {
        return task.copyWith(isCompleted: isCompleted);
      }
      return task;
    }).toList();

    notifyListeners();
  }
}
