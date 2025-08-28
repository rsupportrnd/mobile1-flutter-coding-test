import 'package:json_annotation/json_annotation.dart';
part 'users_request_model.g.dart';

@JsonSerializable()
class UsersRequestModel {
  UsersRequestModel();

factory UsersRequestModel.fromJson(Map<String, dynamic> json) => _$UsersRequestModelFromJson(json);
Map<String, dynamic> toJson() => _$UsersRequestModelToJson(this);
}
