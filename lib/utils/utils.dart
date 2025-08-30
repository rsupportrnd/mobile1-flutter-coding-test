import 'package:mobile1_flutter_coding_test/commons/enums.dart';

DateTime dateTimeFromTimestamp(dynamic val) {
  if ( val is String ) {
    return DateTime.parse(val);
  } else if ( val is int ) {
    return DateTime.fromMillisecondsSinceEpoch(val);
  }

  throw Exception('dateTimeFromTimestamp는 String 또는 int만 받을 수 있음');
}

int timestampToInt(dynamic val) {

  if ( val is String ) {
    return DateTime.parse(val).millisecondsSinceEpoch;
  } else if ( val is DateTime) {
    return val.millisecondsSinceEpoch;
  }

  throw Exception('timestampToInt는 String 또는 DateTime만 받을 수 있음');

}

UserStatus userStatusFromValue(dynamic val) {
  if ( val is String ) {
    return UserStatus.fromString(val);
  } else if ( val is int ) {
    return UserStatus.values[val];
  }

  throw Exception('userStatusFromValue는 String 또는 int만 받을 수 있음');
}

UserRole userRoleFromValue(dynamic val) {
  if ( val is String ) {
    return UserRole.fromString(val);
  } else if ( val is int ) {
    return UserRole.values[val];
  }

  throw Exception('userRoleFromValue은 String 또는 int만 받을 수 있음');
}

String userStatusToString(UserStatus val) {
  return val.value;
}

String userRoleToString(UserRole val) {
  return val.value;
}