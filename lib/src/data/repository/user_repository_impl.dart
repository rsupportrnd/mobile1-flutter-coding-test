import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/core/util/api_util.dart';
import 'package:mobile1_flutter_coding_test/src/data/data.dart';
import 'package:mobile1_flutter_coding_test/src/domain/domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository_impl.g.dart';

@riverpod
UserRepository userRepository(Ref ref) {
  final UserDatasource datasource = ref.read(userDatasourceProvider);
  return UserRepositoryImpl(datasource: datasource);
}

class UserRepositoryImpl with ApiUtilMixin implements UserRepository {
  final UserDatasource _datasource;

  const UserRepositoryImpl({
    required final UserDatasource datasource,
  }) : _datasource = datasource;

  @override
  Future<UserListResponseEntity> getUserList() async {
    return safeApiCall<UserListResponseEntity>(() async {
      final UserListResponseModel model = await _datasource.getUserList();
      return UserMapper.userListModelToEntity(model);
    });
  }
}
