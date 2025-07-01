// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => _UserEntity(
      userId: json['userId'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      profilePicture: json['profilePicture'] as String,
      status: json['status'] as String,
      role: json['role'] as String,
    );

Map<String, dynamic> _$UserEntityToJson(_UserEntity instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'email': instance.email,
      'profilePicture': instance.profilePicture,
      'status': instance.status,
      'role': instance.role,
    };
