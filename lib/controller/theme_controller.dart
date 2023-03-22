import 'package:flutter/material.dart';
import 'package:rs_flutter_test/config/theme.dart';

const String darkMode = 'darkMode';

class ThemeController extends ChangeNotifier {
  ThemeData _themeData = AppThemes.lightThemeData;
  ThemeData get themeData => _themeData;

  void toggleDarkMode() {
    _themeData = _themeData == AppThemes.darkThemeData
        ? AppThemes.lightThemeData
        : AppThemes.darkThemeData;
    notifyListeners();
  }
}
