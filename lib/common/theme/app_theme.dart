import 'package:flutter/material.dart';

final appTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF23272F),
  cardColor: const Color(0xFF282C34),
  canvasColor: const Color(0xFF23272F),
  primaryColor: const Color(0xFF4F8CFF),
  hintColor: const Color(0xFFBDBDBD),
  dividerColor: const Color(0xFF353945),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF23272F),
    foregroundColor: Color(0xFFE3E3E3),
    elevation: 0,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xFFE3E3E3)),
    bodyMedium: TextStyle(color: Color(0xFFE3E3E3)),
    bodySmall: TextStyle(color: Color(0xFFBDBDBD)),
    titleLarge: TextStyle(color: Color(0xFFE3E3E3)),
    titleMedium: TextStyle(color: Color(0xFFE3E3E3)),
    titleSmall: TextStyle(color: Color(0xFFBDBDBD)),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Color.fromARGB(255, 197, 207, 226), // 원하는 커서 색상으로 변경
    selectionColor: Color(0x334F8CFF), // 선택 영역 색상(선택)
    selectionHandleColor: Color(0xFF4F8CFF), // 핸들 색상(선택)
  ),
  iconTheme: const IconThemeData(color: Color(0xFFE3E3E3)),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF4F8CFF),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF23272F),
    selectedItemColor: Color(0xFF4F8CFF),
    unselectedItemColor: Color(0xFFBDBDBD),
  ),
);
