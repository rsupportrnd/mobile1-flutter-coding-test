import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'custom_theme.g.dart';

enum CustomThemeMode {
  light(Colors.black, Colors.white, Color.fromRGBO(36, 41, 46, 1)),
  dark(Colors.white, Color(0xFF0D1117), Color.fromRGBO(22, 27, 34, 1));

  const CustomThemeMode(
      this.foregroundColor, this.backgroundColor, this.appBarColor);

  final Color foregroundColor;
  final Color backgroundColor;
  final Color appBarColor;
}

@riverpod
class CustomTheme extends _$CustomTheme {
  @override
  CustomThemeMode build() => CustomThemeMode.light;

  void setThemeMode({required bool isDarkMode}) {
    state = isDarkMode ? CustomThemeMode.dark : CustomThemeMode.light;
  }
}
