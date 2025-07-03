import 'package:mobile1_flutter_coding_test/common/network/custom_exceptions.dart';
import 'package:mobile1_flutter_coding_test/common/viewmodel/base_viewmodel.dart';
import 'package:mobile1_flutter_coding_test/common/viewmodel/viewmodel_state.dart';
import 'package:mobile1_flutter_coding_test/domain/entities/message_entity.dart';
import 'package:mobile1_flutter_coding_test/domain/usecases/get_room_message_usecase.dart';
import 'package:mobile1_flutter_coding_test/domain/usecases/post_room_message_usecase.dart';

class RoomViewModel extends BaseViewModel {
  final String roomId;
  final GetRoomMessageUseCase getRoomMessageUseCase;
  final PostRoomMessageUseCase postRoomMessageUseCase;
  ViewModelState<List<MessageEntity>> _messages = ViewModelState.loading();
  ViewModelState<List<MessageEntity>> get messagesState => _messages;

  RoomViewModel({
    required this.roomId,
    required this.getRoomMessageUseCase,
    required this.postRoomMessageUseCase,
  }) {
    fetchMessages();
  }

  void setMessages(ViewModelState<List<MessageEntity>> state) {
    _messages = state;
    notifyListeners();
  }

  Future<void> fetchMessages() async {
    try {
      setMessages(ViewModelState.success(data: await getRoomMessageUseCase.call(roomId: roomId)));
    } on NetworkException catch (e) {
      setMessages(ViewModelState.error(error: e.message));
    } on UnknownException catch (e) {
      setMessages(ViewModelState.error(error: e.message));
    } catch (e) {
      setMessages(ViewModelState.error(error: e.toString()));
    }
  }

  Future<void> sendMessage(String message) async {
    final sentMessage = await postRoomMessageUseCase.call(
      message: MessageEntity(
        sender: 'me',
        roomId: roomId,
        messageId: message.hashCode.toString(),
        content: message,
        timestamp: DateTime.now(),
      ),
    );
    List<MessageEntity> previousMessages = [];
    if (messagesState is ViewModelStateSuccess<List<MessageEntity>>) {
      previousMessages = (messagesState as ViewModelStateSuccess<List<MessageEntity>>).data;
    }
    setMessages(ViewModelState.success(data: [...previousMessages, sentMessage]));
  }
}
