import 'package:mobile1_flutter_coding_test/app/index.dart';

final GoRouter router = GoRouter(
  initialLocation: '/users',
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppScaffold(state: state, child: child),
      routes: [
        GoRoute(
          path: '/users',
          pageBuilder: (context, state) => const NoTransitionPage(child: UserListScreen()),
        ),
        GoRoute(
          path: '/rooms',
          pageBuilder: (context, state) => const NoTransitionPage(child: RoomListScreen()),
        ),
      ],
    ),

    // ShellRoute 밖에 두어 바텀 네비게이션 제외
    GoRoute(
      path: '/messages/:roomId',
      name: 'messages',
      builder: (context, state) {
        final roomId = state.pathParameters['roomId']!;

        return MessageListScreen(roomId: roomId);
      },
    ),
  ],
);
