import 'package:mobile1_flutter_coding_test/index.dart';
import 'package:http/http.dart' as http;


@Injectable(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  @override
  Future<List<UserModel>> fetchUsers() async{
    final response =
        await http.get(Uri.https(ApiPaths.baseUrl, ApiPaths.users));
    if (response.statusCode == 200) {
      final UserResponseModel userResponseModel = UserResponseModel.fromJson(jsonDecode(response.body));
      return userResponseModel.users;
    } else {
      throw Exception('Failed to load users');
    }
  }

}