import 'package:mobile1_flutter_coding_test/src/data/data.dart';
import 'package:mobile1_flutter_coding_test/src/domain/domain.dart';

final class UserMapper {
  const UserMapper._();

  static UserEntity userModelToEntity(UserModel model) => UserEntity(
        userId: model.userId,
        name: model.name,
        email: model.email,
        profilePicture: model.profilePicture,
        status: model.status,
        role: model.role,
      );

  static UserListResponseEntity userListModelToEntity(UserListResponseModel model) =>
      UserListResponseEntity(
        users: model.users.map(userModelToEntity).toList(),
      );
}
