import 'package:flutter/material.dart';

final ThemeData WHITE_THEME = ThemeData(
  textTheme: const TextTheme(
    bodySmall: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Color.fromRGBO(36, 41, 46, 1)),
    bodyLarge: TextStyle(color: Colors.white),
  ),
);

final ThemeData DARK_THEME = ThemeData(
    textTheme: const TextTheme(
        bodySmall: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Color.fromRGBO(22, 27, 34, 1)),
        bodyLarge: TextStyle(color: Color(0xFF0D1117))));
