import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile1_flutter_coding_test/shared/enum/role_type.dart';
import 'package:mobile1_flutter_coding_test/shared/enum/user_status.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserListModel with _$UserListModel {
  factory UserListModel({
    @Default([]) List<UserModel> users,
  }) = _UserListModel;

  factory UserListModel.fromJson(Map<String, dynamic> json) =>
      _$UserListModelFromJson(json);
}

@freezed
class UserModel with _$UserModel {
  factory UserModel({
    required String userId,
    required String name,
    required String email,
    required String profilePicture,
    @Default(UserStatus.offline) UserStatus status,
    @Default(RoleType.member) RoleType role,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
