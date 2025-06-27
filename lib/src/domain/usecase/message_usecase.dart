import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/data/data.dart';
import 'package:mobile1_flutter_coding_test/src/domain/domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'message_usecase.g.dart';

@riverpod
MessageUseCase messageUseCase(Ref ref) {
  final MessageRepository messageRepository =
      ref.read(messageRepositoryProvider);
  return MessageUseCase(messageRepository: messageRepository);
}

class MessageUseCase {
  final MessageRepository messageRepository;

  MessageUseCase({required this.messageRepository});

  Future<MessageListResponseEntity> getMessageList() async {
    final MessageListResponseModel response =
        await messageRepository.getRemoteMessageList();
    return MessageListResponseEntity.fromModel(response);
  }

  Future<List<MessageEntity>> getLocalMessages({required String roomId}) {
    return messageRepository.getLocalMessageList(roomId: roomId);
  }

  Future<void> saveMessages({
    required String roomId,
    required List<MessageEntity> messages,
  }) {
    return messageRepository.saveMessages(
      roomId: roomId,
      messages: messages,
    );
  }
}
