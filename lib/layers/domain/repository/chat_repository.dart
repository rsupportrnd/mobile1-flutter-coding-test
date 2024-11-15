import '../model/model.dart';

abstract interface class ChatRepository {
  Future<List<ChatMessage>> fetchChatMessage();
}

abstract interface class ChatLocalRepository {
  Future<void> addMessage(List<ChatMessage> message);
  List<ChatMessage> getAllMessages();
}