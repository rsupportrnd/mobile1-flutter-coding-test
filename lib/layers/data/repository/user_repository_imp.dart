import 'package:mobile1_flutter_coding_test/common/common.dart';
import 'package:mobile1_flutter_coding_test/layers/data/mapper/user_mapper.dart';
import 'package:mobile1_flutter_coding_test/layers/domain/model/user.dart';

import '../../domain/repository/user_repository.dart';
import '../source/source.dart';

class UserRepositoryImp implements UserRepository {
  final RemoteDataSources _remoteDataSource;

  UserRepositoryImp([RemoteDataSources? dataSource])
      : _remoteDataSource = dataSource ?? locator();

  @override
  Future<List<User>> fetchUsers() async {
    try {
      final response = await _remoteDataSource.fetchUsers();
      return UserMapper.toDomainList(response);
    } catch (e) {
      throw Exception('Failed to load users : $e');
    }
  }
}
