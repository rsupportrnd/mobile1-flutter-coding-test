import 'package:mobile1_flutter_coding_test/features/user/data/models/user_model.dart';
import 'package:mobile1_flutter_coding_test/features/user/domain/repositories/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_list_provider.g.dart';


@riverpod
class UserListController extends _$UserListController {
  @override
  Future<List<User>> build() async {
    return await _getUsers();
  }

  Future<List<User>> _getUsers() async {
    return ref.read(userRepositoryProvider).getUsers();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _getUsers());
  }
}