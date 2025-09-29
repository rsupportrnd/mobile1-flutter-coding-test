import 'package:mobile1_flutter_coding_test/core/network/app_dio_client.dart';
import 'package:mobile1_flutter_coding_test/features/user/data/repositories/user_repository_impl.dart';
import 'package:mobile1_flutter_coding_test/features/user/data/sources/user_api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/user_model.dart';

part 'user_repository.g.dart';

@Riverpod(keepAlive: true)
UserRepository userRepository(Ref ref) {
  final dio = ref.read(dioClientProvider);
  final apiService = UserApiService(dio);
  return UserRepositoryImpl(apiService, dio);
}
abstract class UserRepository {
  Future<List<User>> getUsers();
}