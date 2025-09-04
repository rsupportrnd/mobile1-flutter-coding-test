import 'package:mobile1_flutter_coding_test/domain/entity/chat_room.dart';

class ChatRoomState {
  final List<ChatRoom> chatRooms;

  ChatRoomState({required this.chatRooms});

  ChatRoomState copyWith({List<ChatRoom>? chatRooms}) {
    return ChatRoomState(chatRooms: chatRooms ?? this.chatRooms);
  }
}
