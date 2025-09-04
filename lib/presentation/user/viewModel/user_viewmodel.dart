import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/core/network/response_result.dart';
import 'package:mobile1_flutter_coding_test/data/repository/user_repository_impl.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/user.dart';
import 'package:mobile1_flutter_coding_test/domain/repository/user_repository.dart';
import 'package:mobile1_flutter_coding_test/presentation/user/state/user_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_viewmodel.g.dart';

@riverpod
class UserViewModel extends _$UserViewModel {
  late final UserRepository userRepository;

  @override
  Future<UserState> build() async {
    userRepository = ref.read(userRepositoryProvider);

    return await _loadUsers();
  }

  Future<UserState> _loadUsers() async {
    // state = state.copyWith(isLoading: true);

    final response = await userRepository.getUsers();
    if (!response.isSuccess) {
      throw Exception('Failed to load users: ${response.code}');
    }
    return UserState(users: response.data);
  }
}
