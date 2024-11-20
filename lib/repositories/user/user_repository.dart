import 'package:mobile1_flutter_coding_test/index.dart';

abstract class UserRepository {
  Future<List<UserModel>> fetchUsers();
}

