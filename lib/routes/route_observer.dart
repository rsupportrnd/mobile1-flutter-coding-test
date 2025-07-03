import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class AutoRouteListener extends AutoRouteObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    debugPrint('[AutoRouteObserver] PUSH: ${route.data?.path}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    debugPrint('[AutoRouteObserver] POP: ${route.data?.path}');
  }
}
