import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rs_flutter_test/core/theme/theme.dart';

part 'theme_notifier_provider.g.dart';

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  @override
  ThemeData build() {
    return WHITE_THEME;
  }

  void toDark() {
    state = DARK_THEME;
  }

  void toWhite() {
    state = WHITE_THEME;
  }
}
