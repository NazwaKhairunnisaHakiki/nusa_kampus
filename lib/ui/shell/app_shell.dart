import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home/home_screen.dart';
import '../home/home_view_model.dart';
import '../schedule/schedule_screen.dart';
import '../schedule/schedule_view_model.dart';
import '../tasks/tasks_screen.dart';
import '../tasks/task_view_model.dart';
import '../announcements/announcements_screen.dart';
import '../announcements/announcements_view_model.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    ScheduleScreen(),
    TasksScreen(),
    AnnouncementsScreen(),
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    await context.read<HomeViewModel>().load();
    await context.read<ScheduleViewModel>().load();
    await context.read<TaskViewModel>().load();
    await context.read<AnnouncementsViewModel>().load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: ListenableBuilder(
        listenable: context.read<TaskViewModel>(),
        builder: (context, child) {
          final pendingCount = context
              .read<TaskViewModel>()
              .pendingTasks
              .length;

          return NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            destinations: [
              const NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Beranda',
              ),
              const NavigationDestination(
                icon: Icon(Icons.calendar_month_outlined),
                selectedIcon: Icon(Icons.calendar_month),
                label: 'Jadwal',
              ),
              NavigationDestination(
                icon: Badge(
                  label: Text('$pendingCount'),
                  child: const Icon(Icons.task_alt_outlined),
                ),
                selectedIcon: Badge(
                  label: Text('$pendingCount'),
                  child: const Icon(Icons.task_alt),
                ),
                label: 'Tugas',
              ),
              const NavigationDestination(
                icon: Icon(Icons.campaign_outlined),
                selectedIcon: Icon(Icons.campaign),
                label: 'Pengumuman',
              ),
            ],
          );
        },
      ),
    );
  }
}
