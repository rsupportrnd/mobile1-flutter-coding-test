import 'package:mobile1_flutter_coding_test/data/datasource/user_datasource.dart';
import 'package:mobile1_flutter_coding_test/data/mapper/user_mapper.dart';
import 'package:mobile1_flutter_coding_test/data/utils/safe_call.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/result.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/user.dart';
import 'package:mobile1_flutter_coding_test/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({required UserDataSource dataSource})
      : _dataSource = dataSource;
  final UserDataSource _dataSource;

  @override
  Future<Result<List<User>>> getUsers() async {
    return await safeCall(() async {
      final response = await _dataSource.getUsers();
      return response.users.map((element) => element.toEntity()).toList();
    });
  }
}
