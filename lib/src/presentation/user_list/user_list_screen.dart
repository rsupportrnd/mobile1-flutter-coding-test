import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/core/common/exception/custom_exception.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/common/base_screen.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/common/error_screen.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/common/loading_indicator.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/user_list/mixin/user_list_event.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/user_list/mixin/user_list_state.dart';

class UserListScreen extends BaseScreen with UserListState, UserListEvent {
  const UserListScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    return getUserListProvider(ref: ref).when(
      data: (data) {
        return Container(
          color: Colors.red,
        );
      },
      error: (error, stackTrace) {
        return ErrorView(
          appException: error is AppException ? error : const UnknownException(),
          onPressed: () async {
            await getUserList(ref);
          },
        );
      },
      loading: () => const LoadingIndicator(),
    );
  }
}
