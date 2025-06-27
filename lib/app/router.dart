import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile1_flutter_coding_test/features/rooms/presentation/room_list_screen.dart';
import 'package:mobile1_flutter_coding_test/features/users/presentation/user_list_screen.dart';

import '../features/messages/bloc/message_bloc.dart';
import '../features/messages/bloc/message_event.dart';
import '../features/messages/data/repositories/message_repository.dart';
import '../features/messages/presentation/message_list_screen.dart';
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
      path: '/messages/:roomId',
      name: 'messages',
      builder: (context, state) {
        final roomId = state.pathParameters['roomId']!;

        return MessageListScreen(roomId: roomId);
      },
    ),
  ],
);
