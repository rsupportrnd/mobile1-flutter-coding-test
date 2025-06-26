import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/domain/entity/user_list_response_entity.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/user_list/provider/user_list_provider.dart';

mixin class UserListState {
  AsyncValue<UserListResponseEntity> getUserListProvider(
          {required WidgetRef ref}) =>
      ref.watch(userListProvider);
}
