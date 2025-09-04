import 'package:mobile1_flutter_coding_test/core/network/request_api.dart';
import 'package:mobile1_flutter_coding_test/data/model/user_model.dart';
import 'package:mobile1_flutter_coding_test/shared/const/api_endpoints.dart';

class UserDatasource {
  Future<UserListModel> getUsersByNetwork() async {
    final response = await RequestApi.request(ApiEndpoints.users,
        fromJson: UserListModel.fromJson);
    return response.data;
  }

  Future<UserListModel> getUsersByLocal() async {
    throw UnimplementedError();
  }
}
