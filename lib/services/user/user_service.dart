import 'package:mobile1_flutter_coding_test/index.dart';

@injectable
class UserService {
  final UserRepository _userRepository;

  UserService(this._userRepository);

  Future<List<UserModel>> fetUsers(UserStatus userStatus) async {
    List<UserModel> response = await _userRepository.fetchUsers();
    if (userStatus == UserStatus.all) {
      return response;
    } else {
      return response
          .where((element) => element.status == userStatus.name)
          .toList();
    }
  }
}
