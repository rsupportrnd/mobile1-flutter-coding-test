import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/domain/entity/message_list_response_entity.dart';
import 'package:mobile1_flutter_coding_test/src/domain/usecase/meeting_room_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'message_list_provider.g.dart';

@Riverpod(keepAlive: true)
class MessageList extends _$MessageList {
  @override
  Future<List<MessageEntity>> build(String roomId) async {
    return await _fetchMessages();
  }

  /// 로컬과 원격 저장소에서 메시지를 가져와 병합
  Future<List<MessageEntity>> _fetchMessages({
    MessageUseCase? messageUseCase,
  }) async {
    final MessageUseCase useCase =
        messageUseCase ?? ref.read(messageUseCaseProvider);

    // 1 로컬 저장소에서 메시지 목록을 가져오기
    final List<MessageEntity> localMessages =
        await useCase.getLocalMessages(roomId: roomId);

    // 2. 원격 API에서 전체 메시지 목록을 가져오기
    final MessageListResponseEntity remoteResponse =
        await useCase.getMessageList();
    // 현재 채팅방(roomId)에 해당하는 메시지만 필터링.
    final List<MessageEntity> remoteMessages = remoteResponse.messages
        .where((message) => message.roomId == roomId)
        .toList();

    // 3. 로컬과 원격 메시지를 병합
    final Map<String, MessageEntity> mergedMessagesMap = {
      for (final message in remoteMessages) message.messageId: message,
      for (final message in localMessages) message.messageId: message,
    };

    // 4. 병합된 메시지 목록을 시간순으로 정렬
    final List<MessageEntity> finalMessages = mergedMessagesMap.values.toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

    await useCase.saveMessages(
      roomId: roomId,
      messages: finalMessages,
    );

    return finalMessages;
  }

  /// 새로운 메시지를 전송
  Future<MessageEntity> sendMessage({
    required String sender,
    required String content,
    MessageUseCase? messageUseCase,
  }) async {
    final String currentRoomId = roomId;

    final MessageEntity newMessage = MessageEntity(
      roomId: currentRoomId,
      messageId: 'local-${DateTime.now().millisecondsSinceEpoch}',
      sender: sender,
      content: content,
      timestamp: DateTime.now(),
    );

    final List<MessageEntity> previousMessages = state.value ?? [];
    // 새 메시지를 추가하고 시간순으로 다시 정렬합니다.
    final List<MessageEntity> updatedMessages = [
      ...previousMessages,
      newMessage
    ]..sort((a, b) => b.timestamp.compareTo(a.timestamp));

    state = AsyncData(updatedMessages);

    final MessageUseCase useCase =
        messageUseCase ?? ref.read(messageUseCaseProvider);
    await useCase.saveMessages(
      roomId: currentRoomId,
      messages: updatedMessages,
    );
    return newMessage;
  }

  /// 메시지 목록을 새로고침
  Future<void> reloadMessages() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchMessages());
  }
}
