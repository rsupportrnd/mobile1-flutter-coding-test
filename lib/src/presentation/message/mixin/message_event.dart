import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/message/provider/message_provider.dart';

mixin class MessageEvent {
  Future<void> sendMessage({
    required WidgetRef ref,
    required String roomId,
    required String sender,
    required String content,
  }) async {
    await ref
        .read(messageListProvider(roomId).notifier)
        .sendMessage(sender: sender, content: content);
  }
}
