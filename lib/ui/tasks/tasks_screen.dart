import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/models/task.dart';
import 'task_view_model.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<TaskViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daftar Tugas',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.error != null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(viewModel.error!),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: viewModel.load,
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _sectionTitle('Belum Selesai', Icons.pending_actions),
              const SizedBox(height: 8),

              if (viewModel.pendingTasks.isEmpty)
                _emptyMessage('Tidak ada tugas yang tertunda.')
              else
                ...viewModel.pendingTasks.map(
                  (task) => _taskTile(task, viewModel),
                ),

              const SizedBox(height: 24),

              _sectionTitle('Selesai', Icons.task_alt),
              const SizedBox(height: 8),

              if (viewModel.completedTasks.isEmpty)
                _emptyMessage('Belum ada tugas yang selesai.')
              else
                ...viewModel.completedTasks.map(
                  (task) => _taskTile(task, viewModel),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _sectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.indigo),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _taskTile(Task task, TaskViewModel viewModel) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: CheckboxListTile(
        value: task.isCompleted,
        onChanged: (checked) {
          if (checked != null) {
            viewModel.toggleTask(task, checked);
          }
        },
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(
          task.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: task.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: Text(
          '${task.description}\n'
          'Tenggat: ${task.dueDate.day}/'
          '${task.dueDate.month}/'
          '${task.dueDate.year}',
        ),
        isThreeLine: true,
      ),
    );
  }

  Widget _emptyMessage(String message) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(child: Text(message, textAlign: TextAlign.center)),
      ),
    );
  }
}
