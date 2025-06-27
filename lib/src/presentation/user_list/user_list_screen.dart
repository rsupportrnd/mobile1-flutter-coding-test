import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/core/core.dart';
import 'package:mobile1_flutter_coding_test/src/domain/domain.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/presentation.dart';

part 'view/user_info_list_view.dart';

///유저들의 정보를 간단히 보여주는 screen
class UserListScreen extends BaseScreen with UserListState, UserListEvent {
  const UserListScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    return watchUserListProvider(ref: ref).when(
      data: (UserListResponseEntity userListEntity) {
        return _UserInfoListView(userListEntity: userListEntity.users);
      },
      error: (error, stackTrace) {
        return ErrorView(
          appException:
              error is AppException ? error : const UnknownException(),
          onPressed: () async {
            await getUserList(ref);
          },
        );
      },
      loading: () => const LoadingIndicator(),
    );
  }

  @override
  PreferredSizeWidget? renderAppBar(BuildContext context, WidgetRef ref) {
    return const CustomAppBar(
      title: UserListStringConstant.title,
      showDivider: true,
    );
  }
}
