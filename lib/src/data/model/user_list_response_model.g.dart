// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_list_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserListResponseModelImpl _$$UserListResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UserListResponseModelImpl(
      users: (json['users'] as List<dynamic>)
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$UserListResponseModelImplToJson(
        _$UserListResponseModelImpl instance) =>
    <String, dynamic>{
      'users': instance.users,
    };

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      userId: json['userId'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      profilePicture: json['profilePicture'] as String,
      status: $enumDecode(_$UserStatusEnumMap, json['status']),
      role: $enumDecode(_$UserRoleEnumMap, json['role']),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
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
