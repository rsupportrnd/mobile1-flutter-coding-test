import 'package:mobile1_flutter_coding_test/data/model/response.dart';

abstract class UserDataSource {
  Future<UserResponse> getUsers();
}
