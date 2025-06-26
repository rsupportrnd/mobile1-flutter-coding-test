import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/common/base/base_screen.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/common/component/custom_app_bar_widget.dart';

part 'view/message_view.dart';
part 'view/message_input_view.dart';

class MessageScreen extends BaseScreen {
  static const String route = 'MessageScreen';

  final String roomId;
  final String roomName;
  const MessageScreen({
    super.key,
    required this.roomId,
    required this.roomName,
  });

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    return Container();
    // return watchMessages(ref: ref, roomId: roomId).when(
    //   data: (List<MessageEntity> messages) {
    //     return Column(
    //       children: [],
    //     );
    //   },
    //   error: (error, stackTrace) => ErrorView(
    //     appException: error is AppException ? error : const UnknownException(),
    //     onPressed: () {},
    //   ),
    //   loading: () => const LoadingIndicator(),
    // );
  }

  @override
  PreferredSizeWidget? renderAppBar(BuildContext context, WidgetRef ref) {
    return CustomAppBar(title: roomName);
  }
}
