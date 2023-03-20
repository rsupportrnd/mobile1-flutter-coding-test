import 'package:flutter/material.dart';

const kPrimaryColor = Colors.blue;

final kDarkThemeData = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF0D1117),
  appBarTheme:
      const AppBarTheme(backgroundColor: Color.fromRGBO(22, 27, 34, 1)),
);

final kLightThemeData = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme:
      const AppBarTheme(backgroundColor: Color.fromRGBO(36, 41, 46, 1)),
);
