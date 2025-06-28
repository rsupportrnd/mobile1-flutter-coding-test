import 'package:freezed_annotation/freezed_annotation.dart';
import '../config/app_constants.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String email,
    required String? profilePicture,
    required String status,
    required String role,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  
  // 상태에 따른 색상 반환
  const User._();
  
  String get statusDisplayName {
    return UserStatusConfig.statusDisplayNames[status] ?? status;
  }
  
  String get roleDisplayName {
    return UserRoleConfig.roleDisplayNames[role] ?? role;
  }

  // 온라인 상태 여부
  bool get isOnline => status == UserStatusConfig.online;

  // 관리자 여부
  bool get isAdmin => role == UserRoleConfig.admin;
} 