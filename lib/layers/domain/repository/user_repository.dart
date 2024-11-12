import '../model/model.dart';

abstract interface class UserRepository {
  Future<List<User>> fetchUsers();
}