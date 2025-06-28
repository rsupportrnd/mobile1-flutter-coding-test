import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import '../config/app_constants.dart';

/// Route 관리를 담당하는 클래스
class RouteManager {
  static const String _tag = AppConstants.routeManagerTag;
  
  static final RouteManager _instance = RouteManager._internal();
  factory RouteManager() => _instance;
  RouteManager._internal();
  
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  
  NavigatorState? get _navigator => navigatorKey.currentState;
  
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
  
  void pop<T extends Object?>([T? result]) {
    if (_navigator?.canPop() == true) {
      developer.log('Popping current route', name: _tag);
      _navigator!.pop<T>(result);
    }
  }
  
  bool canPop() {
    return _navigator?.canPop() ?? false;
  }
} 