import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  void switchThemeMode(ThemeMode mode) {
    if (mode != state) emit(mode);
  }
}
