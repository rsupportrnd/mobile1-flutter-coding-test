import 'package:flutter/material.dart';

class ThemeColor {
  Color textColor = Colors.black;
  Color appBarColor = Color.fromRGBO(36, 41, 46, 1);
  Color scaffoldBgcolor = Colors.white;

  void themeColorChange(bool val) {
    if (val) {
      textColor = Colors.white;
      appBarColor = Color.fromRGBO(22, 27, 34, 1);
      scaffoldBgcolor = const Color(0xFF0D1117);
      print(scaffoldBgcolor);
    } else {
      textColor = Colors.black;
      appBarColor = Color.fromRGBO(36, 41, 46, 1);
      scaffoldBgcolor = Colors.white;
      print(textColor);
    }
  }
}
