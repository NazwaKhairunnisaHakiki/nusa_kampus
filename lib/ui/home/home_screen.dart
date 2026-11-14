import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/models/course.dart';
import '../../domain/models/task.dart';
import 'home_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<HomeViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'NusaKampus',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => viewModel.load(),
          ),
        ],
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
                  const Icon(Icons.error_outline, size: 48),
                  const SizedBox(height: 12),
                  Text(viewModel.error!),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => viewModel.load(),
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: viewModel.load,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'Selamat Datang!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'Berikut ringkasan aktivitas kampusmu.',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                const SizedBox(height: 24),

                _buildSectionTitle('Kuliah Hari Ini', Icons.school_outlined),
                const SizedBox(height: 12),

                if (viewModel.todayCourses.isEmpty)
                  _buildEmptyMessage('Tidak ada jadwal kuliah hari ini.')
                else
                  ...viewModel.todayCourses.map(
                    (course) => _courseCard(course),
                  ),

                const SizedBox(height: 24),

                _buildSectionTitle(
                  'Tugas Belum Selesai',
                  Icons.assignment_outlined,
                ),
                const SizedBox(height: 12),

                if (viewModel.pendingTasks.isEmpty)
                  _buildEmptyMessage('Semua tugas sudah selesai!')
                else
                  ...viewModel.pendingTasks.map((task) => _taskCard(task)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
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

  Widget _courseCard(Course course) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0xFFE8EAF6),
          child: Icon(Icons.menu_book, color: Colors.indigo),
        ),
        title: Text(
          course.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${course.lecturer}\n${course.startTime} - ${course.endTime} • ${course.room}',
        ),
        isThreeLine: true,
      ),
    );
  }

  Widget _taskCard(Task task) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0xFFFFF3E0),
          child: Icon(Icons.assignment, color: Colors.orange),
        ),
        title: Text(
          task.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(task.description),
      ),
    );
  }

  Widget _buildEmptyMessage(String message) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ),
      ),
    );
  }
}
