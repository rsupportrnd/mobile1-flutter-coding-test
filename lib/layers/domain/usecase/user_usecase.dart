import '../../../common/common.dart';
import '../domain.dart';
import 'base.dart';

/// 유저 목록을 가져오는 유스케이스
class FetchUsersUseCase implements UseCase<List<User>, void> {
  final UserRepository _userRepository;

  FetchUsersUseCase([UserRepository? userRepository])
      : _userRepository = userRepository ?? locator();

  @override
  Future<List<User>> execute() {
    return _userRepository.fetchUsers();
  }
}