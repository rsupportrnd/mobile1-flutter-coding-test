import 'package:mobile1_flutter_coding_test/index.dart';

@injectable
class UserService {
  final UserRepository _userRepository;

  UserService(this._userRepository);

  Future<List<UserModel>> fetUsers() async {
    return await _userRepository.fetchUsers();
  }
}
