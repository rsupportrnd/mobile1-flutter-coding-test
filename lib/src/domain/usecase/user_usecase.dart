import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/data/model/user_list_response_model.dart';
import 'package:mobile1_flutter_coding_test/src/data/repository/user_repository_impl.dart';
import 'package:mobile1_flutter_coding_test/src/domain/repository/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_usecase.g.dart';

@riverpod
Future<UserListResponseModel> getUserListUseCase(Ref ref) {
  final UserRepository repo = ref.read(userRepositoryProvider);
  return repo.getUserList();
}
