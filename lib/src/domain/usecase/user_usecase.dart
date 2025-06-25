import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/data/model/user_list_response_model.dart';
import 'package:mobile1_flutter_coding_test/src/data/repository/user_repository_impl.dart';
import 'package:mobile1_flutter_coding_test/src/domain/entity/user_list_response_entity.dart';
import 'package:mobile1_flutter_coding_test/src/domain/repository/user_repository.dart';
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
    try {
      final UserListResponseModel response = await userRepository.getUserList();
      return UserListResponseEntity.fromModel(response);
    } catch (e) {
      rethrow;
    }
  }
}
