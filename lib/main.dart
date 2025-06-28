import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/app_theme.dart';
import 'screens/main_screen.dart';
import 'utils/logger.dart';

void main() {
  Logger.lifecycle('앱 시작');
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Logger.lifecycle('MyApp 빌드');
    
    return MaterialApp(
      title: 'RSupport Chat App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
