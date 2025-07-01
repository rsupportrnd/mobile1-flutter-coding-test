import 'dart:convert';
import 'package:mobile1_flutter_coding_test/data/models/message_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLocalDataSource {
  static const _messagesKey = 'messages';

  Future<MessageModel> postMessage(MessageModel message) async {
    final messages = await getMessages();
    messages.add(message);
    await saveMessages(messages);
    return message;
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
}
