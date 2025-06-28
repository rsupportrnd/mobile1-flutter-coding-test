import 'package:mobile1_flutter_coding_test/app/index.dart';

abstract class UserRepository {
  Future<List<User>> getUsers();
}