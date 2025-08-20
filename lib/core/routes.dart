import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/presentation/home/bloc/home_bloc.dart';
import 'package:mobile1_flutter_coding_test/presentation/home/home_shell.dart';
import 'package:mobile1_flutter_coding_test/presentation/startup/startup_view.dart';
import 'package:mobile1_flutter_coding_test/presentation/users/user_detail/user_detail_view.dart';

class AppRoutes {
  static const String splash = '/'; // boot
  static const String home = '/home'; // 메인 : 쉘 라우트 바텀 네비 (상태 유지)
  static const String users = '/home/users'; // 유저 리스트
  static const String rooms = '/home/rooms'; // 방 리스트
  static const String userDetail = '/home/users/:userId'; // 유저 상세
  static const String chat = '/home/rooms/:roomId/chat'; // 방 상세
}

class Routes {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: HomeShell(),
          transitionDuration: const Duration(milliseconds: 220),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final fade = CurvedAnimation(curve: Curves.easeInOut, parent: animation);
            return FadeTransition(opacity: fade, child: child);
          },
        ),
        routes: [
          GoRoute(
            path: 'users/:userId',
            pageBuilder: (context, state) {
              final id = state.pathParameters['userId'] ?? '';
              final extra = state.extra;
              final pageChild = (extra is UserDetailArgs)
                  ? UserDetailView(userId: id, user: extra.user, isMe: extra.isMe)
                  : UserDetailView(userId: id);
              return CustomTransitionPage(
                child: pageChild,
                transitionDuration: const Duration(milliseconds: 260),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
                  final offset = Tween<Offset>(begin: const Offset(0.1, 0.0), end: Offset.zero).animate(curved);
                  return SlideTransition(position: offset, child: FadeTransition(opacity: curved, child: child));
                },
              );
            },
          ),
          GoRoute(
            path: 'rooms/:roomId/chat',
            pageBuilder: (context, state) {
              final child = Container();
              return CustomTransitionPage(
                child: child,
                transitionDuration: const Duration(milliseconds: 260),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
                  final offset = Tween<Offset>(begin: const Offset(0.1, 0.0), end: Offset.zero).animate(curved);
                  return SlideTransition(position: offset, child: FadeTransition(opacity: curved, child: child));
                },
              );
            },
          ),
        ],
      ),
    ],
  );
}
