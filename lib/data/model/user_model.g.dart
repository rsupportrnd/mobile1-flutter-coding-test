// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserListModelImpl _$$UserListModelImplFromJson(Map<String, dynamic> json) =>
    _$UserListModelImpl(
      users: (json['users'] as List<dynamic>?)
              ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$UserListModelImplToJson(_$UserListModelImpl instance) =>
    <String, dynamic>{
      'users': instance.users,
    };

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      userId: json['userId'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      profilePicture: json['profilePicture'] as String,
      status: $enumDecodeNullable(_$UserStatusEnumMap, json['status']) ??
          UserStatus.offline,
      role: $enumDecodeNullable(_$RoleTypeEnumMap, json['role']) ??
          RoleType.member,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'email': instance.email,
      'profilePicture': instance.profilePicture,
      'status': _$UserStatusEnumMap[instance.status]!,
      'role': _$RoleTypeEnumMap[instance.role]!,
    };

const _$UserStatusEnumMap = {
  UserStatus.online: 'online',
  UserStatus.offline: 'offline',
  UserStatus.away: 'away',
  UserStatus.doNotDisturb: 'do_not_disturb',
};

const _$RoleTypeEnumMap = {
  RoleType.admin: 'admin',
  RoleType.member: 'member',
};
