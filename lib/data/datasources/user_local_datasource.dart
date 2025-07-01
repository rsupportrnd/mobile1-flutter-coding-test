import 'dart:convert';
import 'package:mobile1_flutter_coding_test/data/models/message_model.dart';
import 'package:mobile1_flutter_coding_test/data/models/room_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLocalDataSource {
  static const _roomsKey = 'rooms';
  static const _messagesKey = 'messages';

  Future<MessageModel> postMessage(MessageModel message) async {
    final messages = await getMessages();
    messages.add(message);
    await saveMessages(messages);

    final rooms = await getRooms();
    final room = rooms.map((room) {
      if (room.roomId == message.roomId) {
        return room.copyWith(
          lastMessage: LastMessageModel(
            sender: message.sender,
            content: message.content,
            timestamp: message.timestamp,
          ),
        );
      }
      return room;
    }).toList();
    await saveRooms(room);
    return message;
  }

  Future<List<RoomModel>> getRooms() async {
    final prefs = await SharedPreferences.getInstance();
    final roomsString = prefs.getString(_roomsKey);
    if (roomsString == null) return [];
    final List<dynamic> roomsJson = jsonDecode(roomsString);
    return roomsJson.map((json) => RoomModel.fromJson(json)).toList();
  }

  Future<List<MessageModel>> getMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final messagesString = prefs.getString(_messagesKey);
    if (messagesString == null) return [];
    final List<dynamic> messagesJson = jsonDecode(messagesString);
    return messagesJson.map((json) => MessageModel.fromJson(json)).toList();
  }

  Future<void> saveMessages(List<MessageModel> messages) async {
    final prefs = await SharedPreferences.getInstance();
    final messagesJson = messages.map((m) => m.toJson()).toList();
    prefs.setString(_messagesKey, jsonEncode(messagesJson));
  }

  Future<void> saveRooms(List<RoomModel> rooms) async {
    final prefs = await SharedPreferences.getInstance();
    final roomsJson = rooms.map((r) => r.toJson()).toList();
    prefs.setString(_roomsKey, jsonEncode(roomsJson));
  }
}
