import 'package:mobile1_flutter_coding_test/domain/entity/chat_room.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/user.dart';

class ChatRoomState {
  final List<ChatRoom> chatRooms;
  final List<User> participantUsers;

  ChatRoomState({
    required this.chatRooms,
    required this.participantUsers,
  });

  ChatRoomState copyWith(
      {List<ChatRoom>? chatRooms, List<User>? participantUsers}) {
    return ChatRoomState(
        participantUsers: participantUsers ?? this.participantUsers,
        chatRooms: chatRooms ?? this.chatRooms);
  }
}
