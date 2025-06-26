import 'package:flutter/foundation.dart';
import '../datasources/user_remote_datasource.dart';
import '../models/user.dart';
import 'user_repository.dart';

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
