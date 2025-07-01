import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile1_flutter_coding_test/data/models/user_model.dart';

part 'user_entity.freezed.dart';
part 'user_entity.g.dart';

@freezed
abstract class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String userId,
    required String name,
    required String email,
    required String profilePicture,
    required String status,
    required String role,
  }) = _UserEntity;

  factory UserEntity.fromModel(UserModel model) => UserEntity(
        userId: model.userId,
        name: model.name,
        email: model.email,
        profilePicture: model.profilePicture,
        status: model.status,
        role: model.role,
      );
  factory UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);
}
