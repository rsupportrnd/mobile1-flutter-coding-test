// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      userId: json['userId'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      profilePicture: json['profilePicture'] as String,
      status: userStatusFromString(json['status'] as String),
      role: userRoleFromString(json['role'] as String),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'email': instance.email,
      'profilePicture': instance.profilePicture,
      'status': _$UserStatusEnumMap[instance.status]!,
      'role': _$UserRoleEnumMap[instance.role]!,
    };

const _$UserStatusEnumMap = {
  UserStatus.unknown: 'unknown',
  UserStatus.offline: 'offline',
  UserStatus.online: 'online',
  UserStatus.doNotDisturb: 'doNotDisturb',
};

const _$UserRoleEnumMap = {
  UserRole.unknown: 'unknown',
  UserRole.member: 'member',
  UserRole.admin: 'admin',
};
