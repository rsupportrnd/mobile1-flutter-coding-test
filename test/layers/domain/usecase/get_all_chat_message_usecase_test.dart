
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mobile1_flutter_coding_test/layers/domain/domain.dart';

import '../../../mock/domain/repository/mock_chat_local_repository.dart';

void main() {
  late GetAllChatMessageUseCase getAllChatMessageUseCase;
  late MockChatLocalRepository mockChatLocalRepository;
  late List<ChatMessage> mockMessages;

  setUp(() {
    mockChatLocalRepository = MockChatLocalRepository();
    getAllChatMessageUseCase = GetAllChatMessageUseCase(mockChatLocalRepository);

    mockMessages = [
      ChatMessage(
        roomId: 'room1',
        messageId: 'msg1',
        sender: 'user1',
        content: '안녕하세요, 오늘 회의 시작할까요?!',
        timestamp: DateTime.parse('2024-11-07T10:00:00Z'),
      ),
      ChatMessage(
        roomId: 'room1',
        messageId: 'msg2',
        sender: 'user2',
        content: '네, 모두 모인 것 같네요.',
        timestamp: DateTime.parse('2024-11-07T10:01:00Z'),
      ),
    ];
  });

  group('GetAllChatMessageUseCase Tests', () {
    test('getAllMessages가 성공하면 채팅메시지를 반환을 확인한다.', () async {
      when(mockChatLocalRepository.getAllMessages()).thenReturn(mockMessages);

      getAllChatMessageUseCase.execute();

      // getAllMessages 호출 여부
      verify(getAllChatMessageUseCase.execute()).called(1);
    });

    test('getAllMessages가 예외를 적용할 때 오류를 확인한다.', () async {
      when(mockChatLocalRepository.getAllMessages()).thenThrow(Exception("Failed to fetch message"));

      // 예외 발생 여부 검증
      expect(() => getAllChatMessageUseCase.execute(), throwsException);
      verify(getAllChatMessageUseCase.execute()).called(1);
    });
  });
}
