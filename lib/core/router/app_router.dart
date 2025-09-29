import 'package:go_router/go_router.dart';
import 'package:mobile1_flutter_coding_test/features/user/presentation/pages/user_list_page.dart';

class AppRouter {
  static const String userList = '/';

  static final GoRouter router = GoRouter(
    initialLocation: userList,
    routes: [
      GoRoute(
        path: userList,
        name: 'userList',
        builder: (context, state) => const UserListPage(),
      ),
    ],
  );
}