import '../../../common/common.dart';
import '../domain.dart';
import 'base.dart';

/// 채팅 메시지 가져오는 유스케이스
class FetchChatMessageUseCase implements UseCase<List<ChatMessage>, void> {
  final ChatRepository _chatRepository;

  FetchChatMessageUseCase([ChatRepository? chatRepository])
      : _chatRepository = chatRepository ?? locator();

  @override
  Future<List<ChatMessage>> execute() {
    return _chatRepository.fetchChatMessage();
  }
}