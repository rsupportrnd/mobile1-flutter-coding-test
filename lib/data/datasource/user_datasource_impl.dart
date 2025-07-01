import 'package:mobile1_flutter_coding_test/data/datasource/user_datasource.dart';
import 'package:mobile1_flutter_coding_test/data/model/response.dart';
import 'package:mobile1_flutter_coding_test/data/utils/json_loader.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/exception.dart';

class UserDataSourceImpl implements UserDataSource {
  UserDataSourceImpl({required IJsonLoader jsonLoader})
      : _jsonLoader = jsonLoader;
  final IJsonLoader _jsonLoader;

  @override
  Future<UsersResponse> getUsers() async {
    try {
      final jsonMap = await _jsonLoader.loadJson('api/users.json');
      return UsersResponse.fromJson(jsonMap);
    } on JsonLoadException {
      rethrow; // Repository에서 처리
    }
  }
}
