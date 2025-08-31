import 'package:go_router/go_router.dart';
import 'package:mobile1_flutter_coding_test/main.dart';

enum Routes {
  userList(path: '/user-list'),
  chatList(path: '/chat-list'),
  ;

  const Routes({required this.path});

  final String path;
}

final router = GoRouter(
  initialLocation: Routes.userList.path,
  routes: [
    ShellRoute(
      routes: [
        GoRoute(
          path: Routes.userList.path,
          builder: (context, state) => const MyHomePage(title: 'User List'),
        ),
        GoRoute(
          path: Routes.chatList.path,
          builder: (context, state) => const MyHomePage(title: 'Chat List'),
        ),
      ],
    ),
  ],
);
