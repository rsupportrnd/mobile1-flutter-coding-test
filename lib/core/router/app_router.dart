import 'package:go_router/go_router.dart';
import 'package:mobile1_flutter_coding_test/features/home/presentation/pages/home_page.dart';

class AppRouter {
  static const String home = '/';

  static final GoRouter router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}