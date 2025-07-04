import 'package:mobile1_flutter_coding_test/data/datasource/local_database_datasource.dart';
import 'package:mobile1_flutter_coding_test/data/datasource/user_datasource.dart';
import 'package:mobile1_flutter_coding_test/data/mapper/user_mapper.dart';
import 'package:mobile1_flutter_coding_test/data/utils/safe_call.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/result.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/user.dart';
import 'package:mobile1_flutter_coding_test/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(
      {required UserDataSource dataSource,
      required LocalDatabaseDataSource localDatabaseDataSource})
      : _dataSource = dataSource,
        _localDatabaseDataSource = localDatabaseDataSource;
  final UserDataSource _dataSource;
  final LocalDatabaseDataSource _localDatabaseDataSource;

  @override
  Future<Result<List<User>>> getUsers() async {
    return await safeCall(() async {
      final response = await _dataSource.getUsers();
      final result =
          response.users.map((element) => element.toEntity()).toList();
      await insertUsers(users: result);
      return result;
    });
  }

  @override
  Future<Result<void>> insertUsers({required List<User> users}) async {
    return await safeCall(() async {
      await _localDatabaseDataSource.insertUsers(
          users: users.map((element) => element.toModel()).toList());
    });
  }

  @override
  Future<Result<List<User>>> selectUsers() async {
    return await safeCall(() async {
      final response = await _localDatabaseDataSource.selectUsers();
      return response.map((element) => element.toEntity()).toList();
    });
  }
}
