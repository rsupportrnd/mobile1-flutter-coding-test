import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

enum UserStatus {
  /// 온라인
  @JsonValue('online')
  online('온라인'),

  /// 오프라인
  @JsonValue('offline')
  offline('오프라인'),

  /// 자리비움
  @JsonValue('away')
  away('자리비움'),

  /// 방해금지
  @JsonValue('do_not_disturb')
  doNotDisturb('방해금지');

  const UserStatus(this.displayText);

  final String displayText;

  Color get color {
    switch (this) {
      case UserStatus.online:
        return Colors.green;
      case UserStatus.offline:
        return Colors.grey;
      case UserStatus.away:
        return Colors.orange;
      case UserStatus.doNotDisturb:
        return Colors.red;
    }
  }
}
