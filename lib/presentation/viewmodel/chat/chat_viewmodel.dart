import 'package:mobile1_flutter_coding_test/domain/entity/message.dart';
import 'package:mobile1_flutter_coding_test/domain/usecase/insert_message_usecase.dart';
import 'package:mobile1_flutter_coding_test/domain/usecase/select_message_usecase.dart';
import 'package:mobile1_flutter_coding_test/presentation/utils/my_logger.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/base_viewmodel.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/chat/chat_state.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/loading_manager.dart';

class ChatViewModel extends BaseViewModel<ChatState> {
  final InsertMessageUseCase _insertMessageUseCase;
  final SelectMessageUseCase _selectMessageUseCase;
  final LoadingManager _loadingManager;

  ChatViewModel({
    required InsertMessageUseCase insertMessageUseCase,
    required SelectMessageUseCase selectMessageUseCase,
    required LoadingManager loadingManager,
  })  : _insertMessageUseCase = insertMessageUseCase,
        _selectMessageUseCase = selectMessageUseCase,
        _loadingManager = loadingManager,
        super(const ChatState());

  String? roomId;

  @override
  void setLoading(bool isLoading) {
    // state = state.copyWith(isLoading: isLoading);
    _loadingManager.isLoading = isLoading;
  }

  setRoomId({required String roomId}) {
    Log.d("setRoomId $roomId");
    if (this.roomId == null) {
      this.roomId = roomId;
      loadMessages();
    }
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
    if (roomId == null) Log.e("roomId is null");
    await runWithResult<List<Message>, void>(
        () => _selectMessageUseCase(roomId: roomId!),
        onSuccess: (items) => _setItems(list: items),
        onFailure: (error) => Log.e(error.toString()));
  }

  Future<bool?> sendMessage({required String message}) async {
    Log.d("sendMessage roomId: $roomId, message: $message");
    if (roomId == null) {
      Log.e("roomId is null");
      return false;
    }
    final msg = Message(
        content: message,
        messageId: DateTime.now().millisecondsSinceEpoch.toString(),
        roomId: roomId!,
        sender: "Me",
        timestamp: DateTime.now().toUtc().toIso8601String());
    return await runWithResult<void, bool>(
        () => _insertMessageUseCase.insertMessage(message: msg),
        onSuccess: (items) {
      _addItem(item: msg);
      return true;
    }, onFailure: (error) {
      Log.e(error.toString());
      return false;
    });
  }
}
