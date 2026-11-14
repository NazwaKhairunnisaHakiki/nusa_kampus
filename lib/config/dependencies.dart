import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/services/campus_service.dart';
import '../data/repositories/schedule_repository.dart';
import '../data/repositories/task_repository.dart';
import '../data/repositories/announcement_repository.dart';

import '../ui/home/home_view_model.dart';
import '../ui/schedule/schedule_view_model.dart';
import '../ui/tasks/task_view_model.dart';
import '../ui/announcements/announcements_view_model.dart';

Widget buildDependencies({required Widget child}) {
  return MultiProvider(
    providers: [
      Provider<CampusService>(create: (_) => CampusService()),
      ProxyProvider<CampusService, ScheduleRepository>(
        update: (_, service, __) => ScheduleRepository(service),
      ),
      ChangeNotifierProxyProvider<CampusService, TaskRepository>(
        create: (context) => TaskRepository(context.read<CampusService>()),
        update: (_, service, previous) => previous ?? TaskRepository(service),
      ),
      ProxyProvider<CampusService, AnnouncementRepository>(
        update: (_, service, __) => AnnouncementRepository(service),
      ),
      ChangeNotifierProvider(
        create: (context) => HomeViewModel(
          context.read<ScheduleRepository>(),
          context.read<TaskRepository>(),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) =>
            ScheduleViewModel(context.read<ScheduleRepository>()),
      ),
      ChangeNotifierProvider(
        create: (context) => TaskViewModel(context.read<TaskRepository>()),
      ),
      ChangeNotifierProvider(
        create: (context) =>
            AnnouncementsViewModel(context.read<AnnouncementRepository>()),
      ),
    ],
    child: child,
  );
}
