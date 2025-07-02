import 'package:mobile1_flutter_coding_test/domain/entity/message.dart';
import 'package:mobile1_flutter_coding_test/domain/usecase/insert_message_usecase.dart';
import 'package:mobile1_flutter_coding_test/domain/usecase/select_message_usecase.dart';
import 'package:mobile1_flutter_coding_test/presentation/utils/my_logger.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/base_viewmodel.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/chat/chat_state.dart';

class ChatViewModel extends BaseViewModel<ChatState> {
  final InsertMessageUseCase _insertMessageUseCase;
  final SelectMessageUseCase _selectMessageUseCase;

  ChatViewModel({
    required InsertMessageUseCase insertMessageUseCase,
    required SelectMessageUseCase selectMessageUseCase,
  })  : _insertMessageUseCase = insertMessageUseCase,
        _selectMessageUseCase = selectMessageUseCase,
        super(const ChatState());

  late String roomId;

  @override
  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  setRoomId({required String roomId}) {
    Log.d("setRoomId $roomId");
    this.roomId = roomId;
  }

  _setItems({required List<Message> list}) {
    Log.d("setItems ${list.length}");
    state = state.copyWith(items: list);
  }

  _addItem({required Message item}) {
    Log.d("setItems ${item.messageId}");
    state = state.copyWith(items: [...state.items, item]);
  }

  Future<void> loadMessages() async {
    Log.d("loadMessages roomId: $roomId");
    await runWithResult<List<Message>>(
        () => _selectMessageUseCase(roomId: roomId),
        onSuccess: (items) => _setItems(list: items),
        onFailure: (error) => Log.e(error.toString()));
  }

  void sendMessage({required String message}) async {
    Log.d("sendMessage roomId: $roomId, message: $message");
    final msg = Message(
        content: message,
        messageId: DateTime.now().millisecondsSinceEpoch.toString(),
        roomId: roomId,
        sender: "Me",
        timestamp: DateTime.now().toUtc().toIso8601String());
    await runWithResult<void>(
        () => _insertMessageUseCase.insertMessage(message: msg),
        onSuccess: (items) => _addItem(item: msg),
        onFailure: (error) => Log.e(error.toString()));
  }
}
