import 'package:json_annotation/json_annotation.dart';
import 'package:mobile1_flutter_coding_test/commons/enums.dart';
import 'package:mobile1_flutter_coding_test/utils/utils.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {

  final String userId;
  final String name;
  final String email;
  final String profilePicture;
  @JsonKey(fromJson: userStatusFromValue, toJson: userStatusToString)
  final UserStatus status;
  @JsonKey(fromJson: userRoleFromValue, toJson: userRoleToString)
  final UserRole role;

  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.profilePicture,
    required this.status,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}