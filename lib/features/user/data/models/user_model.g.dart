// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  userId: json['userId'] as String,
  name: json['name'] as String,
  email: json['email'] as String,
  profilePicture: json['profilePicture'] as String,
  status: _statusFromJson(json['status'] as String),
  role: _roleFromJson(json['role'] as String),
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'userId': instance.userId,
  'name': instance.name,
  'email': instance.email,
  'profilePicture': instance.profilePicture,
  'status': _statusToJson(instance.status),
  'role': _roleToJson(instance.role),
};
