import 'package:flutter_test/flutter_test.dart';
import 'package:mobile1_flutter_coding_test/common/common.dart';
import 'package:mockito/mockito.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/chat/chat_viewmodel.dart';
import 'package:mobile1_flutter_coding_test/layers/domain/domain.dart';

import '../../../mock/domain/usecase/mock_add_chat_message_usecase.dart';
import '../../../mock/domain/usecase/mock_fetch_chat_message_usecase.dart';
import '../../../mock/domain/usecase/mock_get_all_chat_message_usecase.dart';
import '../../../mock/utils/mock_authorization.dart';

//@GenerateMocks([Authorization])
void main() {
  late ChatViewModel viewModel;
  late MockFetchChatMessageUseCase mockFetchChatMessageUseCase;
  late MockAddChatMessageUseCase mockAddChatMessageUseCase;
  late MockGetAllChatMessageUseCase mockGetAllChatMessageUseCase;
  late MockAuthorization mockAuthorization;
  late List<ChatMessage> mockMessages;

  setUp(() {
    mockFetchChatMessageUseCase = MockFetchChatMessageUseCase();
    mockAddChatMessageUseCase = MockAddChatMessageUseCase();
    mockGetAllChatMessageUseCase = MockGetAllChatMessageUseCase();
    mockAuthorization = MockAuthorization();

    viewModel = ChatViewModel(
      fetchChatMessageUseCase: mockFetchChatMessageUseCase,
      addChatMessageUseCase: mockAddChatMessageUseCase,
      getAllChatMessageUseCase: mockGetAllChatMessageUseCase,
    );

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

  group('ChatViewModel Tests', () {
    test('초기값 상태를 확인한다.', () {
      expect(viewModel.isLoading, true);
      expect(viewModel.isError, false);
      expect(viewModel.errorMessage, '');
      expect(viewModel.chatMessageList, []);
    });

    test('LocalDB에 데이터가 존재하지 않아 API 호출해서 ChatMessageList를 불러오는지 확인한다.', () async {
      when(mockGetAllChatMessageUseCase.execute()).thenReturn(mockMessages);
      when(mockFetchChatMessageUseCase.execute()).thenAnswer((_) async => mockMessages);

      viewModel.initRoomId('room1');
      await viewModel.fetchChatMessageList();

      // API 호출 후 ChatMessageList를 불러오는지 확인
      // fetchChatMessageList 중간 mockMessages.reversed를 사용하기때문에
      // mockMessages.reversed를 사용하여 확인
      expect(viewModel.isLoading, false);
      expect(viewModel.isError, false);
      expect(viewModel.chatMessageList, mockMessages.reversed);
    });

    test('LocalDB에 데이터가 존재하고 불러온 데이터를 확인한다.', () async {
      when(mockGetAllChatMessageUseCase.execute()).thenReturn(mockMessages);

      viewModel.initRoomId('room1');
      await viewModel.fetchChatMessageList();

      // fetchChatMessageList 중간 mockMessages.reversed를 사용하기때문에
      // mockMessages.reversed를 사용하여 확인
      expect(viewModel.isLoading, false);
      expect(viewModel.isError, false);
      expect(viewModel.chatMessageList, mockMessages.reversed);
    });

    test('sendMessage 호출 후 chatMessageList insert, chatComposerController clear를 확인한다.', () async {
      when(await mockAddChatMessageUseCase.execute(any)).thenAnswer((_) async => {});
      when(mockGetAllChatMessageUseCase.execute()).thenReturn(mockMessages);

      const content = 'Test message';
      viewModel.chatComposerController.text = content;
      when(mockAuthorization.userId).thenReturn('user1');

      viewModel.initRoomId('room1');
      await viewModel.fetchChatMessageList();
      viewModel.sendMessage();

      verify(await mockAddChatMessageUseCase.execute(any)).called(1);
      expect(viewModel.chatMessageList[0].content, content);
      expect(viewModel.chatComposerController.text, isEmpty);
    });

    test('fetchChatMessageList 호출 시 에러가 발생하면 에러 상태, 메시지를 출력하는지 확인합니다.', () async {
      when(mockGetAllChatMessageUseCase.execute()).thenThrow(Exception(AppStrings.unexpectedError));

      expect(viewModel.isLoading, true);
      expect(viewModel.isError, false);
      expect(viewModel.errorMessage, '');

      await viewModel.fetchChatMessageList();

      // 에러상태, 메시지 출력되는지 확인
      expect(viewModel.isLoading, false);
      expect(viewModel.isError, true);
      expect(viewModel.errorMessage, AppStrings.unexpectedError);
    });

    test('onRetry 호출 시 LocalDB의 데이터를 다시 가져오는지 확인합니다.', () async {
      when(mockGetAllChatMessageUseCase.execute()).thenReturn(mockMessages);

      viewModel.initRoomId('room1');
      viewModel.onRetry();

      // 채팅 메세지가 다시 로드되는지 확인
      expect(viewModel.isLoading, false);
      expect(viewModel.errorMessage, '');
      expect(viewModel.chatMessageList, mockMessages.reversed);
    });
  });
}
