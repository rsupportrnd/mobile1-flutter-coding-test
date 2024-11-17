
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mobile1_flutter_coding_test/layers/domain/domain.dart';

import '../../../mock/domain/repository/mock_chat_repository.dart';

void main() {
  late FetchChatMessageUseCase fetchChatMessageUseCase;
  late MockChatRepository mockChatRepository;
  late List<ChatMessage> mockMessages;

  setUp(() {
    mockChatRepository = MockChatRepository();
    fetchChatMessageUseCase = FetchChatMessageUseCase(mockChatRepository);

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

  group('FetchChatMessageUseCase Tests', () {
    test('fetchChatMessage 성공하면 채팅메시지를 반환을 확인한다.', () async {
      when(mockChatRepository.fetchChatMessage()).thenAnswer((_) async => mockMessages);

      final result = await fetchChatMessageUseCase.execute();

      // 반환된 결과, fetchChatMessage 호출 여부
      expect(result, mockMessages);
      verify(mockChatRepository.fetchChatMessage()).called(1);
    });

    test('fetchChatMessage 예외를 적용할 때 오류를 확인한다.', () async {
      when(mockChatRepository.fetchChatMessage()).thenThrow(Exception("Failed to fetch meeting room"));

      // 예외 발생 여부 검증
      expect(() => fetchChatMessageUseCase.execute(), throwsException);
      verify(mockChatRepository.fetchChatMessage()).called(1);
    });
  });
}
