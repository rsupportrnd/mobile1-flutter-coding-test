import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/domain/entity/message_list_response_entity.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/meeting_room_list/provider/meeting_room_list_provider.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/message/provider/message_list_provider.dart';

mixin class MessageEvent {
  Future<MessageEntity> sendMessage({
    required WidgetRef ref,
    required String roomId,
    required String sender,
    required String content,
  }) async {
    return await ref
        .read(messageListProvider(roomId).notifier)
        .sendMessage(sender: sender, content: content);
  }

  void updateLastMessage({
    required WidgetRef ref,
    required MessageEntity messageEntity,
  }) {
    ref.read(meetingRoomListProvider.notifier).updateLastMessage(messageEntity: messageEntity);
  }
}
