import 'package:flutter/material.dart';
import '../config/app_constants.dart';

/// 색상 관련 유틸리티 클래스
class ColorUtils {
  static Color getStatusColor(String status) {
    switch (status) {
      case UserStatusConfig.online:
        return const Color(AppThemeConfig.onlineColorValue);
      case UserStatusConfig.offline:
        return const Color(AppThemeConfig.offlineColorValue);
      case UserStatusConfig.away:
        return const Color(AppThemeConfig.awayColorValue);
      case UserStatusConfig.doNotDisturb:
        return const Color(AppThemeConfig.dndColorValue);
      default:
        return const Color(AppThemeConfig.offlineColorValue);
    }
  }

  static Color getRoleColor(String role) {
    switch (role) {
      case UserRoleConfig.admin:
        return const Color(AppThemeConfig.adminColorValue);
      case UserRoleConfig.member:
        return const Color(AppThemeConfig.memberColorValue);
      default:
        return const Color(AppThemeConfig.memberColorValue);
    }
  }

  static ColorScheme createColorScheme() {
    return ColorScheme.fromSeed(
      seedColor: const Color(AppThemeConfig.primaryColorValue),
    );
  }

  // 텍스트 색상 (밝기에 따라)
  static Color getTextColor(Color backgroundColor) {
    return backgroundColor.computeLuminance() > 0.5 
        ? Colors.black87 
        : Colors.white;
  }
} 