import 'package:intl/intl.dart';
import 'package:mobile1_flutter_coding_test/index.dart';

part 'message_list_state.dart';

part 'message_list_cubit.freezed.dart';

@injectable
class MessageListCubit extends Cubit<MessageListState> {
  final MessageService _messageService;

  MessageListCubit(this._messageService)
      : super(const MessageListState.initial());

  Future<void> fetchMessagesByRoomNumber({required String roomId}) async {
    emit(const MessageListState.loading());
    try {
      emit(MessageListState.loaded(
          await _messageService.fetchAllMessages(roomId: roomId)));
    } catch (e) {
      emit(MessageListState.error(e.toString()));
    }
  }

  void addMessage(MessageModel message) {
    try {
      final currentState = state;
      if (currentState is _Loaded) {
        final currentMessages = currentState.messages;
        emit(MessageListState.loaded([..._messageService.addMessageToList(message: message, list: currentMessages)]));
      }
    } catch (e) {
      emit(MessageListState.error(e.toString()));
    }
  }

  MessageModel? createMessage(
      {required String roomId, required String content}) {
    final currentState = state;
    if (currentState is _Loaded && roomId.isNotEmpty && content.isNotEmpty) {
      return _messageService.createMessage(
          roomId: roomId, content: content, list: currentState.messages);
    } else {
      return null;
    }
  }

  void scrollToEnd(ScrollController scrollController) {
    _messageService.scrollToEnd(scrollController);
  }
}
