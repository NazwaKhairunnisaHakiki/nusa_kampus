import 'package:flutter/material.dart';

import '../../data/repositories/task_repository.dart';
import '../../domain/models/task.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskRepository _repository;

  TaskViewModel(this._repository) {
    _repository.addListener(_onTasksChanged);
  }

  bool isLoading = false;
  String? error;

  List<Task> get pendingTasks =>
      _repository.tasks.where((task) => !task.isCompleted).toList();

  List<Task> get completedTasks =>
      _repository.tasks.where((task) => task.isCompleted).toList();

  void _onTasksChanged() {
    notifyListeners();
  }

  Future<void> load() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      await _repository.getTasks();
    } catch (e) {
      error = 'Failed to load tasks: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleTask(Task task, bool isCompleted) async {
    await _repository.toggleTask(task.id, isCompleted);
  }

  @override
  void dispose() {
    _repository.removeListener(_onTasksChanged);
    super.dispose();
  }
}
