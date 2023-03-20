import 'package:flutter/material.dart';

class ThemeColor {
  Color textColor = Colors.black;
  Color appBarColor = const Color.fromRGBO(36, 41, 46, 1);
  Color scaffoldBgcolor = Colors.white;

  void themeColorChange(bool val) {
    if (val) {
      textColor = Colors.white;
      appBarColor = const Color.fromRGBO(22, 27, 34, 1);
      scaffoldBgcolor = const Color(0xFF0D1117);
    } else {
      textColor = Colors.black;
      appBarColor = const Color.fromRGBO(36, 41, 46, 1);
      scaffoldBgcolor = Colors.white;
    }
  }
}
