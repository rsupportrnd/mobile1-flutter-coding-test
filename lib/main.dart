import 'package:flutter/material.dart';
import 'package:rs_flutter_test/page/my_home_page.dart';
import 'package:rs_flutter_test/styles/theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;
  List<bool> switchinitials = [false, true, false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeMode,
      home: MyHomePage(
        switchinitials: switchinitials,
        onChangeTheme: (value) => setState(() {
          _themeMode = value;
        }),
      ),
    );
  }
}
