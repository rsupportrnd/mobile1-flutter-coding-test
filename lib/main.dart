import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/common/locator/locator.dart';
import 'package:mobile1_flutter_coding_test/common/theme/app_theme.dart';
import 'package:mobile1_flutter_coding_test/routes/app_router.dart';
import 'package:mobile1_flutter_coding_test/routes/route_observer.dart';

void main() {
  setupLocator();
  runApp(Main());
}

class Main extends StatelessWidget {
  Main({super.key});

  final appRouter = AppRouter();
  final routeObserver = AutoRouteListener();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      color: Colors.black,
      theme: appTheme,
      darkTheme: appTheme,
      themeMode: ThemeMode.dark,
      routerConfig: appRouter.config(
        navigatorObservers: () => [routeObserver],
      ),
    );
  }
}
