import 'package:mobile1_flutter_coding_test/core/network/response_result.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/user.dart';

abstract class UserRepository {
  Future<ResponseResult<List<User>>> getUsers();
}
