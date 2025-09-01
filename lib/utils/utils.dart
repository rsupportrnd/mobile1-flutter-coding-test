import 'package:mobile1_flutter_coding_test/commons/enums.dart';
import 'package:intl/intl.dart';

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

extension KoreanDateTimeFormat on DateTime {
  String formatKorean({DateTime? now}) {
    final DateTime _now = (now ?? DateTime.now()).toLocal();
    final DateTime _dt  = this.toLocal();

    final bool isToday =
        _dt.year == _now.year && _dt.month == _now.month && _dt.day == _now.day;

    if (isToday) {
      return DateFormat('a hh:mm', 'ko').format(_dt);
    } else {
      return DateFormat('yyyy-MM-dd').format(_dt);
    }

    return toString();
  }
}