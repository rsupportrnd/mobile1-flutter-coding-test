import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rs_flutter_test/controller/theme_controller.dart';
import 'package:rs_flutter_test/presentation/view/home_view.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeController>(
            create: (_) => ThemeController(),
          ),
        ],
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: context.watch<ThemeController>().themeData,
      home: const HomeView(),
    );
  }
}
