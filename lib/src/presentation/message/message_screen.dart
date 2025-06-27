import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/core/core.dart';
import 'package:mobile1_flutter_coding_test/src/domain/domain.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/presentation.dart';

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
          child: watchMessagesProvider(
            ref: ref,
            roomId: roomId,
          ).when(
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
                    .reloadMessages();
              },
            ),
            loading: () => const LoadingIndicator(),
          ),
        ),
        _MessageInputView(
          controller: controller,
          onSend: (String text) async {
            final MessageEntity messageEntity = await sendMessage(
              ref: ref,
              roomId: roomId,
              sender: MessageStringConstant.me,
              content: text,
            );
            controller.clear();

            updateLastMessage(
              ref: ref,
              messageEntity: messageEntity,
            );

            if (scrollController.hasClients) {
              scrollController.animateTo(
                scrollController.position.minScrollExtent,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            }
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
