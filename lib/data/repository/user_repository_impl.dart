import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mobile1_flutter_coding_test/data/datasource/user_datasource.dart';
import 'package:mobile1_flutter_coding_test/data/model/user_model.dart';
import 'package:mobile1_flutter_coding_test/domain/repository/user_repository.dart';

part 'user_repository_impl.g.dart';

@riverpod
UserRepository userRepository(Ref ref) {
  final userDatasource = UserDatasource();
  return UserRepositoryImpl(userDatasource: userDatasource);
}

class UserRepositoryImpl implements UserRepository {
  final UserDatasource userDatasource;

  UserRepositoryImpl({required this.userDatasource});

  @override
  Future<List<User>> getUsers() async {
    return getUsersByNetwork();
  }

  @override
  Future<List<User>> getUsersByLocal() async {
    throw UnimplementedError();
  }

  @override
  Future<List<User>> getUsersByNetwork() async {
    final response = await userDatasource.getUsersByNetwork();
    return _convertToEntity(response);
  }

  List<User> _convertToEntity(UserListModel userList) {
    return userList.users
        .map((user) => User(
            userId: user.userId,
            name: user.name,
            email: user.email,
            profilePicture: user.profilePicture,
            status: user.status,
            role: user.role))
        .toList();
  }
}
