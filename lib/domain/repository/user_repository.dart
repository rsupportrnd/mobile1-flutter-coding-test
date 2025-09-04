import 'package:mobile1_flutter_coding_test/domain/entity/user.dart';

abstract class UserRepository {
  Future<List<User>> getUsersByNetwork();
  Future<List<User>> getUsersByLocal();
  Future<List<User>> getUsers();
}
