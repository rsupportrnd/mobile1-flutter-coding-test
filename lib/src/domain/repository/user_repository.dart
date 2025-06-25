import 'package:mobile1_flutter_coding_test/src/data/model/user_list_response_model.dart';

abstract interface class UserRepository {
  Future<UserListResponseModel> getUserList();
}
