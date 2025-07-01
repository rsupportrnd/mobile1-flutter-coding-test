import 'package:mobile1_flutter_coding_test/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<List<UserEntity>> getUsers();
}
