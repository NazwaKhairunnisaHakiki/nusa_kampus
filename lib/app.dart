import 'package:flutter/material.dart';

import 'config/dependencies.dart';
import 'ui/shell/app_shell.dart';

class NusaKampusApp extends StatelessWidget {
  const NusaKampusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return buildDependencies(
      child: MaterialApp(
        title: 'NusaKampus',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          scaffoldBackgroundColor: const Color(0xFFF7F8FC),
        ),
        home: const AppShell(),
      ),
    );
  }
}
