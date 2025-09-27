import '../../data/models/user_model.dart';

abstract class UserRepository {
  Future<List<User>> getUsers();
}