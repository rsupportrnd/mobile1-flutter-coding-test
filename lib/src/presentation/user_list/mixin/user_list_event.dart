import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/user_list/provider/user_list_provider.dart';

mixin class UserListEvent {
  Future<void> getUserList(WidgetRef ref) async =>
      await ref.read(userListProvider.notifier).getUserList();
}
