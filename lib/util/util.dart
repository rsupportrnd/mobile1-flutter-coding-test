import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/enum/enum.dart';

DateTime dateTimeFromTimestamp(String val) {
  return DateTime.parse(val);
}

UserStatus userStatusFromString(String val) {
  switch ( val ) {
    case 'offline':
      return UserStatus.offline;
    case 'online':
      return UserStatus.online;
    case 'do_not_disturb':
      return UserStatus.doNotDisturb;
    case 'away':
      return UserStatus.away;
  }

  return UserStatus.unknown;
}

UserRole userRoleFromString(String val) {
  switch ( val ) {
    case 'member':
      return UserRole.member;
    case 'admin':
      return UserRole.admin;
  }

  return UserRole.unknown;
}