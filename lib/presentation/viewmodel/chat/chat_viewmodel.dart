import 'package:mobile1_flutter_coding_test/domain/entity/message.dart';
import 'package:mobile1_flutter_coding_test/domain/usecase/insert_message_usecase.dart';
import 'package:mobile1_flutter_coding_test/domain/usecase/select_message_by_room_id_usecase.dart';
import 'package:mobile1_flutter_coding_test/presentation/utils/my_logger.dart';
import 'package:mobile1_flutter_coding_test/presentation/utils/toast_service.dart';
import 'package:mobile1_flutter_coding_test/presentation/utils/utils.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/base_viewmodel.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/chat/chat_state.dart';
import 'package:mobile1_flutter_coding_test/presentation/utils/loading_manager.dart';

class ChatViewModel extends BaseViewModel<ChatState> {
  final InsertMessageUseCase _insertMessageUseCase;
  final SelectMessagesByRoomIdUseCase _selectMessageUseCase;
  final LoadingManager _loadingManager;
  final ToastService _toastService;

  ChatViewModel({
    required InsertMessageUseCase insertMessageUseCase,
    required SelectMessagesByRoomIdUseCase selectMessageUseCase,
    required LoadingManager loadingManager,
    required ToastService toastService,
  })  : _insertMessageUseCase = insertMessageUseCase,
        _selectMessageUseCase = selectMessageUseCase,
        _loadingManager = loadingManager,
        _toastService = toastService,
        super(const ChatState());

  String? roomId;

  @override
  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
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
    final tempRoomId = roomId;
    if (tempRoomId == null) return;
    await runWithResult<List<Message>, void>(
        () => _selectMessageUseCase(roomId: tempRoomId),
        onSuccess: (items) => _setItems(list: items),
        onFailure: (error) {
          Log.e(error.toString());
          _toastService.show("데이터베이스에서 Message 데이터를 불러오지 못했습니다.");
        });
  }

  Future<bool?> sendMessage({required String message}) async {
    Log.d("sendMessage roomId: $roomId, message: $message");
    final tempRoomId = roomId;
    if (tempRoomId == null) {
      Log.e("roomId is null");
      return false;
    }

    return await runWithResult<Message, bool>(
        () => _insertMessageUseCase.insertMessage(
            message: Utils().makeMessage(
                content: message,
                sender: "Me",
                roomId: tempRoomId)), onSuccess: (item) {
      _addItem(item: item);
      return true;
    }, onFailure: (error) {
      Log.e(error.toString());
      _toastService.show("메시지 전송에 실패했습니다.");
      return false;
    });
  }
}
