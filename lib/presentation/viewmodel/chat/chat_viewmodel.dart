import 'package:mobile1_flutter_coding_test/domain/entity/message.dart';
import 'package:mobile1_flutter_coding_test/domain/usecase/get_message_usecase.dart';
import 'package:mobile1_flutter_coding_test/presentation/utils/my_logger.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/base_viewmodel.dart';
import 'package:mobile1_flutter_coding_test/presentation/viewmodel/chat/chat_state.dart';

class ChatViewModel extends BaseViewModel<ChatState> {
  final GetMessageUseCase _getMessageUseCase;

  ChatViewModel({
    required GetMessageUseCase getMessageUseCase,
  })  : _getMessageUseCase = getMessageUseCase,
        super(const ChatState());

  @override
  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  _setItems({required List<Message> list}) {
    state = state.copyWith(items: list);
  }

  Future<void> loadMessages() async {
    await runWithResult<List<Message>>(() => _getMessageUseCase(),
        onSuccess: (items) => _setItems(list: items),
        onFailure: (error) => Log.e(error.toString()));
  }

  void sendMessage({required String message}) {}
}
