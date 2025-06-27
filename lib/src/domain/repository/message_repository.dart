import '../entity/message_list_response_entity.dart';

abstract interface class MessageRepository {
  Future<MessageListResponseEntity> getRemoteMessageList();

  Future<List<MessageEntity>> getLocalMessageList({required String roomId});

  Future<void> saveMessages({
    required String roomId,
    required List<MessageEntity> messages,
  });
}
