import 'package:freezed_annotation/freezed_annotation.dart';

enum RoleType {
  /// 관리자
  @JsonValue('admin')
  admin,

  /// 멤버
  @JsonValue('member')
  member,
}
