import 'package:mobile1_flutter_coding_test/core/network/response_codes.dart';
import 'package:mobile1_flutter_coding_test/core/provider/current_user_provider.dart';
import 'package:mobile1_flutter_coding_test/data/repository/room_message_repository_impl.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/user.dart';
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

  void sendMessage(String text, ChatController chatController, String roomId,
      User user) async {
    final message = SenderMessage(
      timestamp: DateTime.now().toIso8601String(),
      name: user.name,
      id: const Uuid().v4(),
      elements: [TextMessageElement(text: text)],
    );

    await ref
        .read(roomMessageRepositoryProvider)
        .addMessageToStorage(roomId, message.toEntity(roomId, user.userId));
    chatController.addMessage(message);
    chatController.scrollToBottom();
  }

  void loadMessagesToController(RoomMessageState data, List<dynamic> userList,
      ChatController chatController, String roomId) {
    final messages = data.getMessages(roomId);
    final currentUser = ref.read(currentUserProvider);
    List<Message> messageList = [];
    for (var message in messages) {
      final userName =
          userList.firstWhere((user) => user.userId == message.sender).name;
      if (message.sender == currentUser.userId) {
        messageList.add(SenderMessage(
          timestamp: message.timestamp,
          name: userName,
          id: message.messageId ?? const Uuid().v4(),
          elements: [TextMessageElement(text: message.content)],
        ));
      } else {
        messageList.add(ReceiverMessage(
          timestamp: message.timestamp,
          name: userName,
          id: message.messageId ?? const Uuid().v4(),
          elements: [TextMessageElement(text: message.content)],
        ));
      }
    }
    chatController.setMessages(messageList);
    chatController.scrollToBottom();

    Future.delayed(const Duration(milliseconds: 50), () {
      chatController.scrollToBottom();
    });
  }
}
