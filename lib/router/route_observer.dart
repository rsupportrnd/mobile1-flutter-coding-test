import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import '../config/app_constants.dart';

/// Route 관찰하는 Navigator Observer
class AppRouteObserver extends NavigatorObserver {
  static const String _tag = AppConstants.appRouteObserverTag;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    
    final currentRouteName = route.settings.name ?? route.runtimeType.toString();
    final previousRouteName = previousRoute?.settings.name ?? 'None';
    
    developer.log(
      'Route PUSH: $previousRouteName → $currentRouteName',
      name: _tag,
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    
    final currentRouteName = route.settings.name ?? route.runtimeType.toString();
    final previousRouteName = previousRoute?.settings.name ?? 'None';
    
    developer.log(
      'Route POP: $currentRouteName → $previousRouteName',
      name: _tag,
    );
  }
} 