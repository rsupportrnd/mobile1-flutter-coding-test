import 'package:json_annotation/json_annotation.dart';
import 'package:mobile1_flutter_coding_test/models/user_model.dart';
part 'users_response_model.g.dart';

@JsonSerializable()
class UsersResponseModel {
  final List<UserModel> users;

  UsersResponseModel({
    required this.users,
  });

  factory UsersResponseModel.fromJson(Map<String, dynamic> json) => _$UsersResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UsersResponseModelToJson(this);
}