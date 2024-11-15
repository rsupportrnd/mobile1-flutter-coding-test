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

/// Local 채팅 메시지 저장하는 유스케이스
class AddChatMessageUseCase implements ParamUseCase<void, List<ChatMessage>> {
  final ChatLocalRepository _chatRepository;

  AddChatMessageUseCase([ChatLocalRepository? chatRepository])
      : _chatRepository = chatRepository ?? locator();

  @override
  Future<void> execute(List<ChatMessage> messages) {
    return _chatRepository.addMessage(messages);
  }
}

/// Local 채팅 메시지 모두 불러오는 유스케이스
class GetAllChatMessageUseCase implements SyncUseCase<List<ChatMessage>, void> {
  final ChatLocalRepository _chatRepository;

  GetAllChatMessageUseCase([ChatLocalRepository? chatRepository])
      : _chatRepository = chatRepository ?? locator();

  @override
  List<ChatMessage> execute() {
    return _chatRepository.getAllMessages();
  }
}