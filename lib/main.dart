import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'features/switch_demo/switch_demo_page.dart';
import 'custom_theme.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(customThemeProvider);

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: themeMode.foregroundColor),
          bodyMedium: TextStyle(color: themeMode.foregroundColor),
        ),
      ),
      home: SwitchDemoPage(
        themeMode: themeMode,
      ),
    );
  }
}
