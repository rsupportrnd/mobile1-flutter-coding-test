import 'package:mobile1_flutter_coding_test/index.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String userId,
    required String name,
    required String email,
    required String profilePicture,
    required String status,
    required String role,
  }) = _UserModel;



  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}