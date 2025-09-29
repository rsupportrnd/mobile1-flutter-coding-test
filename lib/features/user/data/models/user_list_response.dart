import 'package:freezed_annotation/freezed_annotation.dart';
import 'user_model.dart';

part 'user_list_response.freezed.dart';
part 'user_list_response.g.dart';

@freezed
abstract class UserListResponse with _$UserListResponse {
  const factory UserListResponse({
    required List<User> users,
  }) = _UserListResponse;

  factory UserListResponse.fromJson(Map<String, dynamic> json) => _$UserListResponseFromJson(json);
}