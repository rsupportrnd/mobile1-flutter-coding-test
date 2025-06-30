import 'package:mobile1_flutter_coding_test/data/model/user_model.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/user.dart';

extension UserModelToEntityExtension on UserModel {
  User toEntity() => User(
      userId: userId,
      name: name,
      email: email,
      profilePicture: profilePicture,
      status: status,
      role: role);
}

extension UserEntityToModelExtension on User {
  UserModel toModel() => UserModel(
      userId: userId,
      name: name,
      email: email,
      profilePicture: profilePicture,
      status: status,
      role: role);
}
