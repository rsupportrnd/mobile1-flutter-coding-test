import 'package:mobile1_flutter_coding_test/core/network/response_codes.dart';
import 'package:mobile1_flutter_coding_test/data/repository/room_message_repository_impl.dart';
import 'package:mobile1_flutter_coding_test/domain/repository/room_message_repository.dart';
import 'package:mobile1_flutter_coding_test/presentation/chat/state/room_message_state.dart';
import 'package:mobile1_flutter_coding_test/shared/extension/chat_toolkit_extension.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../shared/widgets/chat_toolkit/chat/message/elements/text_message_element.dart';
import '../../../shared/widgets/chat_toolkit/chat_toolkit.dart';

part 'chat_view_model.g.dart';

@riverpod
class ChatViewModel extends _$ChatViewModel {
  late final RoomMessageRepository roomMessageRepository;

  @override
  Future<RoomMessageState> build() async {
    roomMessageRepository = ref.read(roomMessageRepositoryProvider);
    return await _getRoomMessages();
  }

  Future<RoomMessageState> _getRoomMessages() async {
    final messages = await roomMessageRepository.getRoomMessages();
    if (messages.code != ResponseCodes.success) {
      throw Exception('실패 에러 코드 : ${messages.code}');
    }

    return RoomMessageState(messages: messages.data ?? {});
  }

  void sendMessage(
      String text, ChatController chatController, String roomId) async {
    final message = SenderMessage(
      timestamp: DateTime.now().toIso8601String(),
      name: 'test',
      id: const Uuid().v4(),
      elements: [TextMessageElement(text: text)],
    );

    await ref
        .read(roomMessageRepositoryProvider)
        .addMessageToStorage(roomId, message.toEntity(roomId, "user1"));
    chatController.addMessage(message);
    chatController.scrollToBottom();
  }
}
