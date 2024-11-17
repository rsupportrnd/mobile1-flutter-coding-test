

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/layers/data/data.dart';
import 'package:mobile1_flutter_coding_test/layers/domain/domain.dart';
import 'package:mockito/mockito.dart';

import '../../../../mock/data/source/local/mock_local_data_source.dart';
import '../../../../mock/data/source/remote/mock_remote_data_source.dart';

void main() {
  late MockRemoteDataSources mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late ChatRemoteRepositoryImp chatRemoteRepositoryImp;
  late ChatLocalRepositoryImp chatLocalRepositoryImp;
  late List<ChatMessageDTO> mockMessagesDTO;
  late List<ChatMessageDAO> mockMessagesDAO;
  late List<ChatMessage> mockMessages;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSources();
    mockLocalDataSource = MockLocalDataSource();
    chatRemoteRepositoryImp = ChatRemoteRepositoryImp(mockRemoteDataSource);
    chatLocalRepositoryImp = ChatLocalRepositoryImp(mockLocalDataSource);

    mockMessagesDTO = [
      ChatMessageDTO(
        roomId: 'room1',
        messageId: 'msg1',
        sender: 'user1',
        content: '안녕하세요, 오늘 회의 시작할까요?!',
        timestamp: DateTime.parse('2024-11-07T10:00:00Z'),
      ),
      ChatMessageDTO(
        roomId: 'room1',
        messageId: 'msg2',
        sender: 'user2',
        content: '네, 모두 모인 것 같네요.',
        timestamp: DateTime.parse('2024-11-07T10:01:00Z'),
      ),
    ];

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

    mockMessagesDAO = [
      ChatMessageDAO(
        roomId: 'room1',
        messageId: 'msg1',
        sender: 'user1',
        content: '안녕하세요, 오늘 회의 시작할까요?!',
        timestamp: '2024-11-07T10:00:00Z',
      ),
      ChatMessageDAO(
        roomId: 'room1',
        messageId: 'msg2',
        sender: 'user2',
        content: '네, 모두 모인 것 같네요.',
        timestamp: '2024-11-07T10:01:00Z',
      ),
    ];
  });

  group('ChatRemoteRepositoryImp Tests', () {
    test('fetchChatMessage가 성공적으로 호출되면 채팅 메시지 목록을 반환합니다.', () async {
      when(mockRemoteDataSource.fetchChatMessage()).thenAnswer((_) async => mockMessagesDTO);

      final result = await chatRemoteRepositoryImp.fetchChatMessage();

      // 채팅 메시지 목록 반환확인
      expect(result.length, 2);
      expect(result[0].content, '안녕하세요, 오늘 회의 시작할까요?!');
      expect(result[1].content, '네, 모두 모인 것 같네요.');
      expect(result, isA<List<ChatMessage>>());
    });

    test('fetchChatMessage 호출 실패 시 예외를 던집니다.', () async {
      when(mockRemoteDataSource.fetchChatMessage()).thenThrow(Exception('Failed to load chat messages'));

      // 실행 및 예외 확인
      expect(() => chatRemoteRepositoryImp.fetchChatMessage(), throwsException);
    });
  });

  group('ChatLocalRepositoryImp Tests', () {
    test('addMessage가 성공적으로 호출되면 메시지가 추가됩니다.', () async {
      when(mockLocalDataSource.addMessages(any)).thenAnswer((_) async => Future.value());

      await chatLocalRepositoryImp.addMessage(mockMessages);

      // addMessage 메서드 호출 확인
      verify(mockLocalDataSource.addMessages(any)).called(1);
    });

    test('LocalDB getAllMessages가 성공적으로 호출되면 메시지 목록을 반환합니다.', () {
      when(mockLocalDataSource.getAllMessages()).thenReturn(mockMessagesDAO);

      final result = chatLocalRepositoryImp.getAllMessages();

      // 메시지 목록 반환 확인
      expect(result.length, 2);
      expect(result[0].content, '안녕하세요, 오늘 회의 시작할까요?!');
      expect(result, isA<List<ChatMessage>>());
    });

    test('LocalDB addMessage 호출 실패 시 예외를 던집니다.', () async {
      when(mockLocalDataSource.addMessages(any)).thenThrow(Exception('Failed to add messages'));

      // 실행 및 예외 확인
      expect(() => chatLocalRepositoryImp.addMessage(mockMessages), throwsException);
    });

    test('LocalDB getAllMessages 호출 실패 시 예외를 던집니다.', () {
      when(mockLocalDataSource.getAllMessages()).thenThrow(Exception('Failed to get messages'));

      // 실행 및 예외 확인
      expect(() => chatLocalRepositoryImp.getAllMessages(), throwsException);
    });
  });
}
