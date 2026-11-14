import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'announcements_view_model.dart';

class AnnouncementsScreen extends StatelessWidget {
  const AnnouncementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<AnnouncementsViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pengumuman Kampus',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: viewModel.load,
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

          if (viewModel.announcements.isEmpty) {
            return const Center(child: Text('Belum ada pengumuman.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: viewModel.announcements.length,
            itemBuilder: (context, index) {
              final announcement = viewModel.announcements[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 14),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Color(0xFFE8EAF6),
                            child: Icon(Icons.campaign, color: Colors.indigo),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              announcement.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Text(announcement.content),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 14,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${announcement.publishedAt.day}/'
                            '${announcement.publishedAt.month}/'
                            '${announcement.publishedAt.year}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
