import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/home/home_screen.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/message/message_screen.dart';
import 'package:mobile1_flutter_coding_test/src/router/router_observer.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter router(Ref ref) {
  final GoRouter goRouter = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/${HomeScreen.route}',
    observers: [RouterObserver()],
    routes: <RouteBase>[
      ///홈
      GoRoute(
        path: '/${HomeScreen.route}',
        name: HomeScreen.route,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
      ),

      ///채팅방
      GoRoute(
        path: '/${MessageScreen.route}/:roomId',
        name: MessageScreen.route,
        builder: (BuildContext context, GoRouterState state) {
          Map<String, dynamic> extraMap = state.extra as Map<String, dynamic>;
          final String roomId = extraMap['roomId'];
          final String roomName = extraMap['roomName'];

          return MessageScreen(
            roomId: roomId,
            roomName: roomName,
          );
        },
      ),
    ],
  );
  return goRouter;
}
