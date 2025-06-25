import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile1_flutter_coding_test/src/core/common/enum/user_enum.dart';
import 'package:mobile1_flutter_coding_test/src/data/model/user_list_response_model.dart';

part 'user_list_response_entity.freezed.dart';
part 'user_list_response_entity.g.dart';

@freezed
class UserListResponseEntity with _$UserListResponseEntity {
  const factory UserListResponseEntity({
    required List<UserEntity> users,
  }) = _UserListResponseEntity;

  factory UserListResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$UserListResponseEntityFromJson(json);

  factory UserListResponseEntity.fromModel(UserListResponseModel model) {
    return UserListResponseEntity(
      users: model.users.map((e) {
        return UserEntity(
          userId: e.userId,
          name: e.name,
          email: e.email,
          profilePicture: e.profilePicture,
          status: UserStatus.values.firstWhere((s) => s == e.status),
          role: UserRole.values.firstWhere((r) => r == e.role),
        );
      }).toList(),
    );
  }
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

  factory UserEntity.fromModel(UserModel model) => UserEntity.fromJson(model.toJson());
}
