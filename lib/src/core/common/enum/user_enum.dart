import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile1_flutter_coding_test/src/core/theme/app_color.dart';

/// 사용자 상태
enum UserStatus {
  online,
  offline,
  away,
  @JsonValue('do_not_disturb')
  doNotDisturb;

  Color getStatusColor() {
    switch (this) {
      case UserStatus.online:
        return AppColors.secondary;
      case UserStatus.offline:
        return AppColors.iconInactive;
      case UserStatus.away:
        return AppColors.orange;
      case UserStatus.doNotDisturb:
        return AppColors.error;
    }
  }
}

/// 사용자 역할
enum UserRole {
  admin,
  member,
}
