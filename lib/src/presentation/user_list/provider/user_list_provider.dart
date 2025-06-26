import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/domain/entity/user_list_response_entity.dart';
import 'package:mobile1_flutter_coding_test/src/domain/usecase/user_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_list_provider.g.dart';

@Riverpod(keepAlive: true)
final class UserList extends _$UserList {
  @override
  Future<UserListResponseEntity> build() async {
    return await _fetchUserList();
  }

  Future<UserListResponseEntity> _fetchUserList({
    UserUseCase? userUseCase,
  }) async {
    final UserUseCase useCase = userUseCase ?? ref.read(userUseCaseProvider);
    return await useCase.getUserList();
  }

  Future<void> getUserList() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchUserList());
  }
}
