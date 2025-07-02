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

  @override
  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  _setItems({required List<Message> list}) {
    state = state.copyWith(items: list);
  }

  _addItem({required Message item}) {
    state = state.copyWith(items: [...state.items, item]);
  }

  Future<void> loadMessages({required String roomId}) async {
    await runWithResult<List<Message>>(
        () => _selectMessageUseCase(roomId: roomId),
        onSuccess: (items) => _setItems(list: items),
        onFailure: (error) => Log.e(error.toString()));
  }

  void sendMessage({required String message}) async {
    // await runWithResult<void>(
    //     () => _insertMessageUseCase.insertMessage(message: message),
    //     onSuccess: (items) => _addItem(item: message),
    //     onFailure: (error) => Log.e(error.toString()));
  }
}
