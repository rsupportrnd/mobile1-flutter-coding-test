import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile1_flutter_coding_test/src/core/common/enum/user_enum.dart';

part 'user_list_response_model.freezed.dart';
part 'user_list_response_model.g.dart';

@freezed
class UserListResponseModel with _$UserListResponseModel {
  const factory UserListResponseModel({
    required List<UserModel> users,
  }) = _UserListResponseModel;

  factory UserListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserListResponseModelFromJson(json);
}

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String userId,
    required String name,
    required String email,
    required String profilePicture,
    required UserStatus status,
    required UserRole role,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}
