import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rsupport/router/route_manager.dart';
import 'package:rsupport/router/route_observer.dart';
import 'screens/main_screen.dart';
import 'config/app_constants.dart';
import 'config/app_text_styles.dart';
import 'utils/color_utils.dart';
import 'utils/logger.dart';

void main() {
  // Logger 초기화
  Logger.setLoggingEnabled(true);
  Logger.info(' 앱 시작 - ${AppConstants.appTitle}');
  Logger.lifecycle('앱 초기화 시작');

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appTitle,
      navigatorKey: RouteManager.navigatorKey,
      navigatorObservers: [
        AppRouteObserver(),
      ],
      theme: ThemeData(
        colorScheme: ColorUtils.createColorScheme(),
        useMaterial3: true,

        // 기본 폰트 패밀리 설정
        fontFamily: 'NotoSans',

        // 텍스트 테마 설정
        textTheme: const TextTheme(
          // 헤드라인
          headlineLarge: AppTextStyles.pageTitle,
          headlineMedium: AppTextStyles.sectionTitle,
          headlineSmall: AppTextStyles.cardTitle,

          // 제목
          titleLarge: AppTextStyles.appBarTitle,
          titleMedium: AppTextStyles.listTitle,
          titleSmall: AppTextStyles.emphasis,

          // 본문
          bodyLarge: AppTextStyles.bodyLarge,
          bodyMedium: AppTextStyles.bodyMedium,
          bodySmall: AppTextStyles.bodySmall,

          // 라벨
          labelLarge: AppTextStyles.buttonLarge,
          labelMedium: AppTextStyles.buttonMedium,
          labelSmall: AppTextStyles.label,
        ),

        // Card 테마
        cardTheme: CardTheme(
          elevation: AppConstants.cardElevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          ),
          color: ColorUtils.createColorScheme().surface,
        ),

        // Input 테마
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          ),
          contentPadding: const EdgeInsets.all(AppConstants.defaultPadding),
          labelStyle: AppTextStyles.inputLabel,
          hintStyle: AppTextStyles.inputHint,
        ),

        // AppBar 테마
        appBarTheme: const AppBarTheme(
          elevation: AppConstants.cardElevation,
          centerTitle: false,
          titleTextStyle: AppTextStyles.appBarTitle,
        ),

        // Button 테마
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            ),
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            textStyle: AppTextStyles.buttonMedium,
          ),
        ),

        // List Tile 테마
        listTileTheme: const ListTileThemeData(
          contentPadding: EdgeInsets.all(AppConstants.defaultPadding),
          titleTextStyle: AppTextStyles.listTitle,
          subtitleTextStyle: AppTextStyles.listSubtitle,
        ),

        // 애니메이션 테마
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
