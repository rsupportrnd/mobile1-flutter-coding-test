import 'package:flutter/material.dart';
import 'route_manager.dart';

/// Route 관리를 위한 헬퍼 클래스
class NavigationHelper {
  static final RouteManager _routeManager = RouteManager();
  
  /// 페이지 이동
  static Future<T?> to<T extends Object?>(Widget page, {String? routeName}) {
    return _routeManager.pushPage<T>(page, routeName: routeName);
  }
  
  /// 뒤로가기
  static void back<T extends Object?>([T? result]) {
    _routeManager.pop<T>(result);
  }
  
  /// 뒤로 갈 수 있는지 확인
  static bool canGoBack() {
    return _routeManager.canPop();
  }
} 