import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

enum RoleType {
  /// 관리자
  @JsonValue('admin')
  admin('관리자'),

  /// 멤버
  @JsonValue('member')
  member('멤버');

  const RoleType(this.displayText);

  final String displayText;

  Color get color {
    switch (this) {
      case RoleType.admin:
        return Colors.teal;
      case RoleType.member:
        return Colors.blue;
    }
  }
}
