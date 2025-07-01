import 'package:mobile1_flutter_coding_test/common/constants/apis.dart';
import 'package:mobile1_flutter_coding_test/common/network/base_request.dart';
import '../models/user_model.dart';

class UserRemoteDataSource extends BaseRequest {
  UserRemoteDataSource({required super.dio});

  Future<List<UserModel>> getUsers() async {
    return call(() async {
      final response = await dio.get(Apis.getUsers);
      return response.data.map((e) => UserModel.fromJson(e)).toList();
    });
  }
}
