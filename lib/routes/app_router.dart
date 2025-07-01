import 'package:auto_route/auto_route.dart';
import 'package:mobile1_flutter_coding_test/routes/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          path: '/',
          children: [
            AutoRoute(
              page: UserListRoute.page,
              path: 'userList',
            ),
            AutoRoute(
              page: RoomListRoute.page,
              path: 'roomList',
            ),
          ],
        ),
        AutoRoute(
          page: RoomRoute.page,
          path: '/room/:roomId',
        ),
      ];
}
