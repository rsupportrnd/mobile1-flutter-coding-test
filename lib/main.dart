import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/routes/app_router.dart';
import 'package:mobile1_flutter_coding_test/routes/route_observer.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  Main({super.key});

  final appRouter = AppRouter();
  final routeObserver = AutoRouteListener();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter.config(
        navigatorObservers: () => [routeObserver],
      ),
    );
  }
}
