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
      List<MessageModel> dbMessages =
          await _messageService.fetchMessageFromLocalDatabase(roomId: roomId);
      List<MessageModel> roomMessages =
          await _messageService.fetchMessagesByRoomNumber(roomId: roomId);

      List<MessageModel> mergedMessages = [...dbMessages, ...roomMessages];
      emit(MessageListState.loaded(
          _messageService.compareToListOrderByAsc(list: mergedMessages)));
    } catch (e) {
      emit(MessageListState.error(e.toString()));
    }
  }

  void addMessage(MessageModel message) {
    try {
      final currentState = state;
      if (currentState is _Loaded) {
        final currentMessages = currentState.messages;
        emit(MessageListState.loaded([...currentMessages, message]));
      }
    } catch (e) {
      emit(MessageListState.error(e.toString()));
    }
  }

  MessageModel? createMessage(
      {required String roomId, required String content}) {
    final currentState = state;
    if (currentState is _Loaded && roomId.isNotEmpty && content.isNotEmpty) {
      late String lastMessageId;
      if (currentState.messages.isEmpty) {
        lastMessageId = 'msg0';
      } else {
        lastMessageId = currentState.messages.last.messageId;
      }
      int lastIndex = int.parse(lastMessageId.split('msg').last);
      return MessageModel(
        roomId: roomId,
        content: content,
        messageId: 'msg${lastIndex + 1}',
        sender: "developer",
        timestamp: DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.now()),
      );
    } else {
      return null;
    }
  }

  void scrollToEnd(ScrollController scrollController) {
    _messageService.scrollToEnd(scrollController);
  }
}
