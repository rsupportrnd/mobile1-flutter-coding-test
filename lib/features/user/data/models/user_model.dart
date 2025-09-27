import 'package:freezed_annotation/freezed_annotation.dart';
import 'user_status.dart';
import 'user_role.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required String userId,
    required String name,
    required String email,
    required String profilePicture,
    @JsonKey(fromJson: _statusFromJson, toJson: _statusToJson)
    required UserStatus status,
    @JsonKey(fromJson: _roleFromJson, toJson: _roleToJson)
    required UserRole role,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

UserStatus _statusFromJson(String status) => UserStatus.fromString(status);
String _statusToJson(UserStatus status) => status.value;

UserRole _roleFromJson(String role) => UserRole.fromString(role);
String _roleToJson(UserRole role) => role.value;