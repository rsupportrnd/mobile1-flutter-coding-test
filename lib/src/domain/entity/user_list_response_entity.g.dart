// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_list_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserListResponseEntityImpl _$$UserListResponseEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$UserListResponseEntityImpl(
      users: (json['users'] as List<dynamic>)
          .map((e) => UserEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$UserListResponseEntityImplToJson(
        _$UserListResponseEntityImpl instance) =>
    <String, dynamic>{
      'users': instance.users,
    };

_$UserEntityImpl _$$UserEntityImplFromJson(Map<String, dynamic> json) =>
    _$UserEntityImpl(
      userId: json['userId'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      profilePicture: json['profilePicture'] as String,
      status: $enumDecode(_$UserStatusEnumMap, json['status']),
      role: $enumDecode(_$UserRoleEnumMap, json['role']),
    );

Map<String, dynamic> _$$UserEntityImplToJson(_$UserEntityImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'email': instance.email,
      'profilePicture': instance.profilePicture,
      'status': _$UserStatusEnumMap[instance.status]!,
      'role': _$UserRoleEnumMap[instance.role]!,
    };

const _$UserStatusEnumMap = {
  UserStatus.online: 'online',
  UserStatus.offline: 'offline',
  UserStatus.away: 'away',
  UserStatus.doNotDisturb: 'do_not_disturb',
};

const _$UserRoleEnumMap = {
  UserRole.admin: 'admin',
  UserRole.member: 'member',
};
