import 'package:mobile1_flutter_coding_test/core/network/request_api.dart';
import 'package:mobile1_flutter_coding_test/core/network/response_result.dart';
import 'package:mobile1_flutter_coding_test/data/model/user_model.dart';
import 'package:mobile1_flutter_coding_test/shared/const/api_endpoints.dart';

class UserDatasource {
  /// 유저 목록 조회
  Future<ResponseResult<UserListModel>> getUsers() async {
    final response = await RequestApi.request(ApiEndpoints.users,
        fromJson: UserListModel.fromJson);
    return response;
  }
}
