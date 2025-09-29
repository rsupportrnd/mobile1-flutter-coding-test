import 'package:mobile1_flutter_coding_test/core/network/app_dio_client.dart';
import 'package:mobile1_flutter_coding_test/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:mobile1_flutter_coding_test/features/chat/data/sources/chat_api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/chat_room.dart';

part 'chat_repository.g.dart';

@Riverpod(keepAlive: true)
ChatRepository chatRepository(Ref ref) {
  final dio = ref.read(dioClientProvider);
  final apiService = ChatApiService(dio);
  return ChatRepositoryImpl(apiService, dio);
}

abstract class ChatRepository {
  Future<List<ChatRoom>> getChatRooms();
}