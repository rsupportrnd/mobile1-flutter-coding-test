import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/common/network/custom_exceptions.dart';
import 'package:mobile1_flutter_coding_test/common/viewmodel/viewmodel_state.dart';
import 'package:mobile1_flutter_coding_test/domain/entities/message_entity.dart';
import 'package:mobile1_flutter_coding_test/domain/usecases/get_room_message_usecase.dart';

class RoomViewModel extends ChangeNotifier {
  final String roomId;
  final GetRoomMessageUseCase getRoomMessageUseCase;
  ViewModelState<List<MessageEntity>> _messages = ViewModelState.loading();
  ViewModelState<List<MessageEntity>> get messagesState => _messages;

  RoomViewModel({
    required this.roomId,
    required this.getRoomMessageUseCase,
  }) {
    fetchMessages();
  }

  void setMessages(ViewModelState<List<MessageEntity>> state) {
    _messages = state;
    notifyListeners();
  }

  void fetchMessages() async {
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
}
