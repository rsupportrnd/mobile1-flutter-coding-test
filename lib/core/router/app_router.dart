import 'package:go_router/go_router.dart';
import 'package:mobile1_flutter_coding_test/features/home/presentation/pages/home_page.dart';
import 'package:mobile1_flutter_coding_test/features/chat/presentation/pages/chat_room_page.dart';

class AppRouter {
  static const String home = '/';
  static const String chatRoom = '/chat/:roomId';

  static final GoRouter router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) {
          return HomePage();
        },
      ),
      GoRoute(
        path: chatRoom,
        name: 'chatRoom',
        builder: (context, state) {
          final roomId = state.pathParameters['roomId']!;
          final roomName = state.uri.queryParameters['roomName'] ?? 'Chat Room';
          return ChatRoomPage(
            roomId: roomId,
            roomName: roomName,
          );
        },
      ),
    ],
  );
}