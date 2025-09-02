import 'package:freezed_annotation/freezed_annotation.dart';

enum UserStatus {
  /// 온라인
  @JsonValue('online')
  online,

  /// 오프라인
  @JsonValue('offline')
  offline,

  /// 자리비움
  @JsonValue('away')
  away,

  /// 방해금지
  @JsonValue('do_not_disturb')
  doNotDisturb,
}
