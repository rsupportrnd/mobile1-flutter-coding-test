import 'package:mobile1_flutter_coding_test/domain/entity/result.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/user.dart';

abstract class UserRepository {
  Future<Result<List<User>>> getUsers();
  Future<Result<void>> insertUsers({required List<User> users});
  Future<Result<List<User>>> selectUsers();
}
