import 'package:flutter/material.dart';

import '../ui/common/themes.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  ThemeData get currentTheme => _isDarkTheme ? kDarkThemeData : kLightThemeData;

  void updateTheme(bool isDarkTheme) {
    _isDarkTheme = isDarkTheme;
    notifyListeners();
  }
}
