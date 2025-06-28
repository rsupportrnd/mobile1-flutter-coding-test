import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import '../config/app_constants.dart';

/// Route 관리를 담당하는 클래스
/// Navigator의 Push 기반으로 페이지 이동을 관리
class RouteManager {
  static const String _tag = AppConstants.routeManagerTag;
  
  // 싱글톤 패턴
  static final RouteManager _instance = RouteManager._internal();
  factory RouteManager() => _instance;
  RouteManager._internal();
  
  // Global Navigator Key
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  
  /// Navigator State 가져오기
  NavigatorState? get _navigator => navigatorKey.currentState;
  
  /// 위젯으로 페이지 이동 (fade 효과 포함)
  Future<T?> pushPage<T extends Object?>(
    Widget page, {
    String? routeName,
  }) async {
    if (_navigator == null) return null;
    
    final route = PageRouteBuilder<T>(
      settings: RouteSettings(
        name: routeName ?? page.runtimeType.toString(),
      ),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
    
    developer.log('Pushing to: ${route.settings.name}', name: _tag);
    return await _navigator!.push<T>(route);
  }
  
  /// 뒤로가기
  void pop<T extends Object?>([T? result]) {
    if (_navigator?.canPop() == true) {
      developer.log('Popping current route', name: _tag);
      _navigator!.pop<T>(result);
    }
  }
  
  /// 뒤로 갈 수 있는지 확인
  bool canPop() {
    return _navigator?.canPop() ?? false;
  }
} 