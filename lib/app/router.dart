import 'package:go_router/go_router.dart';
import 'package:mobile1_flutter_coding_test/features/users/presentation/user_list_screen.dart';

import '../presentation/chat_screen.dart';
import '../presentation/room_list_screen.dart';
import 'app_scaffold.dart';

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
      path: '/rooms/:id/chat',
      builder: (context, state) {
        final roomId = state.pathParameters['id']!;
        return ChatScreen(roomId: roomId);
      },
    ),
  ],
);
