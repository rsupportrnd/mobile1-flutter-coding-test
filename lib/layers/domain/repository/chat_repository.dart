import '../model/model.dart';

abstract interface class ChatRepository {
  Future<List<ChatMessage>> fetchChatMessage();
}