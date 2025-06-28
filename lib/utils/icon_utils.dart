import 'package:flutter/material.dart';
import '../config/app_constants.dart';

/// 아이콘 관련 유틸리티 클래스
class IconUtils {
  static IconData getStatusIcon(String status) {
    switch (status) {
      case UserStatusConfig.online:
        return Icons.circle;
      case UserStatusConfig.offline:
        return Icons.circle_outlined;
      case UserStatusConfig.away:
        return Icons.schedule;
      case UserStatusConfig.doNotDisturb:
        return Icons.do_not_disturb;
      default:
        return Icons.help_outline;
    }
  }

  static IconData getRoleIcon(String role) {
    switch (role) {
      case UserRoleConfig.admin:
        return Icons.admin_panel_settings;
      case UserRoleConfig.member:
        return Icons.person;
      default:
        return Icons.person;
    }
  }

  // Common Icon
  static const IconData refresh = Icons.refresh;
  static const IconData error = Icons.error;
  static const IconData loading = Icons.hourglass_empty;
  static const IconData search = Icons.search;
  static const IconData filter = Icons.filter_list;
  static const IconData settings = Icons.settings;
  static const IconData back = Icons.arrow_back;
  static const IconData forward = Icons.arrow_forward_ios;
  static const IconData send = Icons.send;
  static const IconData attachment = Icons.attach_file;
  static const IconData camera = Icons.camera_alt;
  static const IconData gallery = Icons.photo_library;
} 