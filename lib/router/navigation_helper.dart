import 'package:flutter/material.dart';
import 'route_manager.dart';

/// Navigation 사용을 위한 헬퍼 클래스
class NavigationHelper {
  static final RouteManager _routeManager = RouteManager();
  
  static Future<T?> to<T extends Object?>(Widget page, {String? routeName}) {
    return _routeManager.pushPage<T>(page, routeName: routeName);
  }
  
  static void back<T extends Object?>([T? result]) {
    _routeManager.pop<T>(result);
  }
  
  static bool canGoBack() {
    return _routeManager.canPop();
  }
} 