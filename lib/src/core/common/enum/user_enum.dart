import 'package:freezed_annotation/freezed_annotation.dart';

/// 사용자 상태
enum UserStatus {
  online,
  offline,
  away,
  @JsonValue('do_not_disturb')
  doNotDisturb,
}

/// 사용자 역할
enum UserRole {
  admin,
  member,
}
