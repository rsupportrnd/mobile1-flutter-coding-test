import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mobile1_flutter_coding_test/common/common.dart';
import 'package:mobile1_flutter_coding_test/layers/domain/domain.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/chat/chat_view.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/chat/chat_viewmodel.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/chat/widget/message_list.dart';
import 'package:provider/provider.dart';
import 'package:mockito/mockito.dart';

import '../../../mock/presentation/mock_chat_viewmodel.dart';

//@GenerateMocks([ChatViewModel])
void main() {
  initializeDateFormatting();

  late MockChatViewModel mockChatViewModel;
  late List<ChatMessage> mackChatMessages;

  setUp(() {
    mockChatViewModel = MockChatViewModel();
    mackChatMessages = [
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

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: ChangeNotifierProvider<ChatViewModel>(
        create: (_) => mockChatViewModel,
        child: const ChatView(title: '프로젝트 A 회의', roomId: 'room1'),
      ),
    );
  }


  group('ChatView Tests', () {
    testWidgets('로딩 중일 때 로딩 인디케이터가 표시되는지 확인한다.', (WidgetTester tester) async {

      when(mockChatViewModel.isLoading).thenReturn(true);
      when(mockChatViewModel.isError).thenReturn(false);
      when(mockChatViewModel.errorMessage).thenReturn('');
      when(mockChatViewModel.chatMessageList).thenReturn([]);
      when(mockChatViewModel.initRoomId('room1')).thenReturn(null);

      await tester.pumpWidget(createWidgetUnderTest());

      // 로딩 화면이 표시 되는지 확인
      expect(mockChatViewModel.isLoading, true);
      expect(find.byType(CupertinoActivityIndicator), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('오류가 발생했을 때 오류 메시지가 표시되는지 확인한다.', (tester) async {
      when(mockChatViewModel.isLoading).thenReturn(false);
      when(mockChatViewModel.isError).thenReturn(true);
      when(mockChatViewModel.errorMessage).thenReturn(AppStrings.unexpectedError);
      when(mockChatViewModel.chatMessageList).thenReturn([]);
      when(mockChatViewModel.initRoomId('room1')).thenReturn(null);

      await tester.pumpWidget(createWidgetUnderTest());

      // 에러 메시지 확인
      expect(find.text(AppStrings.unexpectedError), findsOneWidget);
    });

    testWidgets('메시지가 정상적으로 화면에 보여지는 확인한다.', (tester) async {
      when(mockChatViewModel.isLoading).thenReturn(false);
      when(mockChatViewModel.isError).thenReturn(false);
      when(mockChatViewModel.errorMessage).thenReturn('');
      when(mockChatViewModel.chatMessageList).thenReturn(mackChatMessages);
      when(mockChatViewModel.initRoomId('room1')).thenReturn(null);

      await tester.pumpWidget(
          MaterialApp(
            home: ChangeNotifierProvider<ChatViewModel>(
              create: (_) => mockChatViewModel,
              child: Scaffold(
                body: Column(
                  children: [
                    MessageList(
                      chatMessages: mockChatViewModel.chatMessageList,
                    ),
                  ],
                ),
              ),
            ),
          ),
      );

      // 메시지가 화면에 표시되는지 확인
      expect(find.text('안녕하세요, 오늘 회의 시작할까요?!'), findsOneWidget);
      expect(find.text('네, 모두 모인 것 같네요.'), findsOneWidget);
    });

    testWidgets('화면 호출과 동시에 fetchChatMessageList 메서드 호출되는지 확인한다.', (tester) async {
      when(mockChatViewModel.isLoading).thenReturn(false);
      when(mockChatViewModel.isError).thenReturn(false);
      when(mockChatViewModel.errorMessage).thenReturn('');
      when(mockChatViewModel.chatMessageList).thenReturn([]);
      when(mockChatViewModel.initRoomId('room1')).thenReturn(null);
      when(mockChatViewModel.chatComposerController).thenReturn(TextEditingController());

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // fetchChatMessageList 메서드가 호출되었는지 확인
      verify(mockChatViewModel.fetchChatMessageList()).called(1);
    });

    testWidgets('텍스트입력, 전송버튼으로 sendMessage 메서드 호출 및 메세지 생성을 확인한다.', (tester) async {
      when(mockChatViewModel.isLoading).thenReturn(false);
      when(mockChatViewModel.isError).thenReturn(false);
      when(mockChatViewModel.errorMessage).thenReturn('');
      when(mockChatViewModel.chatMessageList).thenReturn([
        ChatMessage(
          roomId: 'room1',
          messageId: 'msg25',
          sender: 'psw2575',
          content: '안녕하세요.',
          timestamp: DateTime.parse('2024-11-07T10:01:00Z'),
        )
      ]);
      when(mockChatViewModel.initRoomId('room1')).thenReturn(null);
      when(mockChatViewModel.chatComposerController).thenReturn(TextEditingController());

      await tester.pumpWidget(createWidgetUnderTest());

      // 입력 필드에 텍스트 입력
      await tester.enterText(find.byType(TextField), '안녕하세요');
      await tester.tap(find.byType(IconButton)); // 전송 버튼 클릭
      await tester.pump();

      // sendMessage 메서드가 호출되었는지 확인
      verify(mockChatViewModel.sendMessage()).called(1);

      // 메시지가 생성되었는지 확인
      expect(find.text('안녕하세요'), findsOneWidget);
    });
  });
}
