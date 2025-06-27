import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile1_flutter_coding_test/src/core/common/enum/user_enum.dart';

part 'user_list_response_entity.freezed.dart';
part 'user_list_response_entity.g.dart';

@freezed
class UserListResponseEntity with _$UserListResponseEntity {
  const factory UserListResponseEntity({
    required List<UserEntity> users,
  }) = _UserListResponseEntity;

  factory UserListResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$UserListResponseEntityFromJson(json);
}

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String userId,
    required String name,
    required String email,
    required String profilePicture,
    required UserStatus status,
    required UserRole role,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);
}
