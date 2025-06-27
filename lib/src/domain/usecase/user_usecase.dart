import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/data/data.dart';
import 'package:mobile1_flutter_coding_test/src/domain/domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_usecase.g.dart';

@riverpod
UserUseCase userUseCase(Ref ref) {
  final UserRepository userRepository = ref.read(userRepositoryProvider);
  return UserUseCase(userRepository: userRepository);
}

class UserUseCase {
  final UserRepository userRepository;

  UserUseCase({required this.userRepository});

  Future<UserListResponseEntity> getUserList() async {
    return await userRepository.getUserList();
  }
}
