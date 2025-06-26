import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/core/common/exception/custom_exception.dart';
import 'package:mobile1_flutter_coding_test/src/core/common/extension/data_time_extension.dart';
import 'package:mobile1_flutter_coding_test/src/core/constant/string_constant/message_string_constant.dart';
import 'package:mobile1_flutter_coding_test/src/core/theme/app_color.dart';
import 'package:mobile1_flutter_coding_test/src/core/theme/typography.dart';
import 'package:mobile1_flutter_coding_test/src/domain/entity/message_list_response_entity.dart';
import 'package:mobile1_flutter_coding_test/src/domain/entity/user_list_response_entity.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/common/base/base_screen.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/common/base/base_view.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/common/component/custom_app_bar_widget.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/common/component/loading_indicator.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/common/component/user_avatar_widget.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/common/error_screen.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/message/mixin/message_event.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/message/mixin/message_state.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/message/provider/message_provider.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/user_list/mixin/user_list_state.dart';

part 'view/message_view.dart';
part 'view/message_input_view.dart';

class MessageScreen extends BaseScreen with MessageState, MessageEvent {
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
    final TextEditingController controller = useTextEditingController();

    final AsyncValue<List<MessageEntity>> messages = watchMessages(
      ref: ref,
      roomId: roomId,
    );

    final ScrollController scrollController = useScrollController();

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollController.position.minScrollExtent);
        }
      });
      return null;
    }, []);

    return Column(
      children: [
        Expanded(
          child: messages.when(
            data: (List<MessageEntity> msgList) {
              return _MessageListView(
                messages: msgList,
                scrollController: scrollController,
              );
            },
            error: (error, stackTrace) => ErrorView(
              appException:
                  error is AppException ? error : const UnknownException(),
              onPressed: () async {
                await ref
                    .read(messageListProvider(roomId).notifier)
                    .loadMessages();
              },
            ),
            loading: () => const LoadingIndicator(),
          ),
        ),
        _MessageInputView(
          controller: controller,
          onSend: (String text) async {
            await sendMessage(
              ref: ref,
              roomId: roomId,
              sender: MessageStringConstant.me,
              content: text,
            );
            if (scrollController.hasClients) {
              scrollController.animateTo(
                scrollController.position.minScrollExtent,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            }
            controller.clear();
          },
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget? renderAppBar(BuildContext context, WidgetRef ref) {
    return CustomAppBar(title: roomName);
  }
}
