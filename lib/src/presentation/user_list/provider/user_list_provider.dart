import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/domain/entity/user_list_response_entity.dart';
import 'package:mobile1_flutter_coding_test/src/domain/usecase/user_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_list_provider.g.dart';

@Riverpod(keepAlive: true)
final class UserListNotifier extends _$UserListNotifier {
  @override
  Future<UserListResponseEntity> build() async {
    return await _fetchUserList();
  }

  Future<UserListResponseEntity> _fetchUserList({
    UserUseCase? userCase,
  }) async {
    final UserUseCase useCase = userCase ?? ref.read(userUseCaseProvider);
    return await useCase.getUserList();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchUserList());
  }
}
