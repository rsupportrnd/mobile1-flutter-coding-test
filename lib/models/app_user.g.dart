// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppUser _$AppUserFromJson(Map<String, dynamic> json) => _AppUser(
  userId: json['userId'] as String,
  name: json['name'] as String? ?? 'unknown',
  email: json['email'] as String? ?? '',
  profilePicture: json['profilePicture'] as String? ?? '',
  status: json['status'] as String? ?? '',
  role: json['role'] as String? ?? '',
);

Map<String, dynamic> _$AppUserToJson(_AppUser instance) => <String, dynamic>{
  'userId': instance.userId,
  'name': instance.name,
  'email': instance.email,
  'profilePicture': instance.profilePicture,
  'status': instance.status,
  'role': instance.role,
};
