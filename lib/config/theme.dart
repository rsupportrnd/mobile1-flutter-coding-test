import 'package:flutter/material.dart';
import 'package:rs_flutter_test/config/color.dart';

/// 앱의 theme을 라이트/다크 모드로 나눠서 관리
class AppThemes {
  static ThemeData get lightThemeData {
    return ThemeData(
      textTheme: const TextTheme(
        bodyText1: TextStyle(color: AppColors.black),
        bodyText2: TextStyle(color: AppColors.black),
      ),
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: AppColors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.blueGray2,
      ),
    );
  }

  static ThemeData get darkThemeData {
    return ThemeData(
      textTheme: const TextTheme(
        bodyText1: TextStyle(color: AppColors.white),
        bodyText2: TextStyle(color: AppColors.white),
      ),
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: AppColors.darkBlueGray2,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkBlueGray1,
      ),
    );
  }
}
