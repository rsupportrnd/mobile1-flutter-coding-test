import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/core/common/exception/custom_exception.dart';
import 'package:mobile1_flutter_coding_test/src/core/constant/string_constant/user_list_string_constant.dart';
import 'package:mobile1_flutter_coding_test/src/core/theme/typography.dart';
import 'package:mobile1_flutter_coding_test/src/core/util/bottom_sheet_modal_util.dart';
import 'package:mobile1_flutter_coding_test/src/domain/entity/user_list_response_entity.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/common/base/base_screen.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/common/base/base_view.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/common/component/custom_app_bar_widget.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/common/component/user_avatar_widget.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/common/component/user_status_widget.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/common/error_screen.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/common/component/loading_indicator.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/user_list/mixin/user_list_event.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/user_list/mixin/user_list_state.dart';

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
