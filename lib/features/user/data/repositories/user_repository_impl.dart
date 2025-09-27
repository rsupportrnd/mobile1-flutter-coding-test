import '../../domain/repositories/user_repository.dart';
import '../models/user_model.dart';
import '../sources/user_api_service.dart';

class UserRepositoryImpl implements UserRepository {
  final UserApiService _apiService;

  UserRepositoryImpl(this._apiService);

  @override
  Future<List<User>> getUsers() async {
    try {
      final response = await _apiService.getUsers();
      return response.users;
    } catch (e) {
      throw Exception('Failed to fetch users: $e');
    }
  }
}