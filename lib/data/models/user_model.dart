/* 
    {
      "userId": "user1",
      "name": "Alice Kim",
      "email": "alice.kim@example.com",
      "profilePicture": "https://picsum.photos/id/1011/200/200",
      "status": "online",
      "role": "admin"
    },

*/

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String userId,
    required String name,
    required String email,
    required String profilePicture,
    required String status,
    required String role,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}
