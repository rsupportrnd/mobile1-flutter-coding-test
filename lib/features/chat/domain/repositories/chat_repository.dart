import 'package:mobile1_flutter_coding_test/core/network/app_dio_client.dart';
import 'package:mobile1_flutter_coding_test/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:mobile1_flutter_coding_test/features/chat/data/sources/chat_api_service.dart';
import 'package:mobile1_flutter_coding_test/features/chat/data/providers/chat_local_service_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/chat_room.dart';
import '../../data/models/chat_message.dart';

part 'chat_repository.g.dart';

@Riverpod(keepAlive: true)
ChatRepository chatRepository(Ref ref) {
  final dio = ref.read(dioClientProvider);
  final apiService = ChatApiService(dio);
  final localService = ref.read(chatLocalServiceProvider);
  return ChatRepositoryImpl(apiService, localService, dio);
}

abstract class ChatRepository {
  Future<List<ChatRoom>> getChatRooms();
  Future<List<ChatMessage>> getMessagesForRoom(String roomId);
  Future<ChatMessage> sendMessage({
    required String roomId,
    required String sender,
    required String content,
  });
}