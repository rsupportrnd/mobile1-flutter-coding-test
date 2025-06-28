import 'package:mobile1_flutter_coding_test/app/index.dart';
import 'package:http/http.dart' as http;


abstract class UserRemoteDataSource {
  Future<List<User>> fetchUsers();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<List<User>> fetchUsers() async {
    final url = Uri.parse(
      'https://raw.githubusercontent.com/rsupportrnd/mobile1-flutter-coding-test/refs/heads/main/api/users.json',
    );

    final response = await client.get(url);

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body) as Map<String, dynamic>;
      final usersJson = jsonMap['users'] as List;
      return usersJson.map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch users: ${response.statusCode}');
    }
  }
}
