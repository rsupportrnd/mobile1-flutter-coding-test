import 'package:go_router/go_router.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/chat_room.dart';
import 'package:mobile1_flutter_coding_test/presentation/chat/chat_room_list.dart';
import 'package:mobile1_flutter_coding_test/presentation/chat/chatting.dart';
import 'package:mobile1_flutter_coding_test/presentation/layout.dart';
import 'package:mobile1_flutter_coding_test/presentation/user/user_list.dart';

enum Routes {
  userList(path: '/user-list'),
  chatList(path: '/chat-list'),
  chatting(path: '/chatting'),
  ;

  const Routes({required this.path});

  final String path;
}

final router = GoRouter(
  initialLocation: Routes.userList.path,
  routes: [
    ShellRoute(
      builder: (context, state, child) => Layout(child),
      routes: [
        GoRoute(
          path: Routes.userList.path,
          builder: (context, state) => const UserList(),
        ),
        GoRoute(
          path: Routes.chatList.path,
          builder: (context, state) => const ChatRoomList(),
        ),
      ],
    ),
    GoRoute(
      path: Routes.chatting.path,
      builder: (context, state) => Chatting(chatRoom: state.extra as ChatRoom),
    ),
  ],
);
