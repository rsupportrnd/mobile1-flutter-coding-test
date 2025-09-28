import 'package:mobile1_flutter_coding_test/features/user/data/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

@riverpod
class UserListProvider extends _$UserListProvider {
  @override
  Future<List<User>> build() async {
    return await _getUsers();
  }

  
  Future<List<User>> _getUsers() async {
    throw UnimplementedError();
  }

  Future<void> refresh() async {
    throw UnimplementedError();
  }

}