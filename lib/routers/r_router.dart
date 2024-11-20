import 'package:mobile1_flutter_coding_test/index.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    errorBuilder: (context, state) =>
        ErrorPage(errorString: state.error.toString()),
    initialLocation: AppPath.userList.toPath,
    routes: [
      ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) {
            return BlocProvider(
              create: (_) => NavigationCubit(),
              child: MainPage(child: child),
            );
          },
          routes: [
            GoRoute(
              path: AppPath.userList.toPath,
              name: AppPath.userList.toName,
              parentNavigatorKey: _shellNavigatorKey,
              pageBuilder: (_, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: BlocProvider<UserListCubit>(
                      create: (_) => getIt<UserListCubit>(),
                      child: const UserListPage())),
              // builder: (context, state) => const UserListPage(),
            ),
            GoRoute(
              path: AppPath.roomList.toPath,
              name: AppPath.roomList.toName,
              parentNavigatorKey: _shellNavigatorKey,
              pageBuilder: (_, state) => NoTransitionPage(
                  key: state.pageKey, child: const RoomListPage()),
              // builder: (context, state) => const RoomListPage(),
            ),
          ]),
      GoRoute(
        path: '${AppPath.chatting.toPath}/:roomId',
        name: AppPath.chatting.toName,
        parentNavigatorKey: _shellNavigatorKey,
        builder: (_, state) =>
            ChattingPage(roomId: state.pathParameters['roomId'].toString()),
      ),
    ]);
