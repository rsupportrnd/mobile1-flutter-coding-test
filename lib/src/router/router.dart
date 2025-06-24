import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/home/home_screen.dart';
import 'package:mobile1_flutter_coding_test/src/router/router_observer.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter router(RouterRef ref) {
  final GoRouter goRouter = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/${HomeScreen.route}',
    observers: [RouterObserver()],
    routes: <RouteBase>[
      GoRoute(
        path: '/${HomeScreen.route}',
        name: HomeScreen.route,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
      ),
    ],
  );
  return goRouter;
}
