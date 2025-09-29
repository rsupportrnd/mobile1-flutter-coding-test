// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserListResponse _$UserListResponseFromJson(Map<String, dynamic> json) =>
    _UserListResponse(
      users: (json['users'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserListResponseToJson(_UserListResponse instance) =>
    <String, dynamic>{'users': instance.users};
