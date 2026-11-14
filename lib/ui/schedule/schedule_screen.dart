import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'schedule_view_model.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ScheduleViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Jadwal Kuliah',
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

          return Column(
            children: [
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'Monday', label: Text('Sen')),
                    ButtonSegment(value: 'Tuesday', label: Text('Sel')),
                    ButtonSegment(value: 'Wednesday', label: Text('Rab')),
                    ButtonSegment(value: 'Thursday', label: Text('Kam')),
                    ButtonSegment(value: 'Friday', label: Text('Jum')),
                  ],
                  selected: {viewModel.selectedDay},
                  onSelectionChanged: (selection) {
                    viewModel.selectDay(selection.first);
                  },
                  showSelectedIcon: false,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: viewModel.filteredCourses.isEmpty
                    ? const Center(
                        child: Text('Tidak ada jadwal pada hari ini.'),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: viewModel.filteredCourses.length,
                        itemBuilder: (context, index) {
                          final course = viewModel.filteredCourses[index];

                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              leading: const CircleAvatar(
                                backgroundColor: Color(0xFFE8EAF6),
                                child: Icon(
                                  Icons.menu_book,
                                  color: Colors.indigo,
                                ),
                              ),
                              title: Text(
                                course.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  '${course.lecturer}\n'
                                  '${course.startTime} - ${course.endTime}\n'
                                  'Room: ${course.room}',
                                ),
                              ),
                              isThreeLine: true,
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
