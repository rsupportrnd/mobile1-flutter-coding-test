import 'package:mobile1_flutter_coding_test/data/datasource/user_datasource.dart';
import 'package:mobile1_flutter_coding_test/data/model/response.dart';
import 'package:mobile1_flutter_coding_test/data/utils/json_loader.dart';

class UserDataSourceImpl implements UserDataSource {
  UserDataSourceImpl({required IJsonLoader jsonLoader})
      : _jsonLoader = jsonLoader;
  final IJsonLoader _jsonLoader;

  @override
  Future<UsersResponse> getUsers() async {
    final jsonMap = await _jsonLoader.loadJson('api/users.json');
    return UsersResponse.fromJson(jsonMap);
  }
}
