import 'package:mobile1_flutter_coding_test/app/index.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<User>> getUsers() async {
    try {
      return await remoteDataSource.fetchUsers();
    } catch (e, stack) {
      debugPrint('UserRepositoryImpl Error: $e\n$stack');
      rethrow;
    }
  }
}
