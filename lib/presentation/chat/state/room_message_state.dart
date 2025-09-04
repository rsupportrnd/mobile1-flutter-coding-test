import 'package:mobile1_flutter_coding_test/domain/entity/message.dart';

class RoomMessageState {
  final Map<String, List<Message>> messages;

  RoomMessageState({required this.messages});

  RoomMessageState copyWith({Map<String, List<Message>>? messages}) {
    return RoomMessageState(messages: messages ?? this.messages);
  }

  List<Message> getMessages(String roomId) {
    return messages[roomId] ?? [];
  }
}
