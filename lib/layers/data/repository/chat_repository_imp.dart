import 'package:mobile1_flutter_coding_test/common/common.dart';

import '../../domain/domain.dart';
import '../data.dart';

class ChatRemoteRepositoryImp implements ChatRepository {
  final RemoteDataSources _remoteDataSource;

  ChatRemoteRepositoryImp([RemoteDataSources? dataSource])
      : _remoteDataSource = dataSource ?? locator();

  @override
  Future<List<ChatMessage>> fetchChatMessage() async {
    print('fetchChatMessage 호출');
    try {
      final response = await _remoteDataSource.fetchChatMessage();
      return ChatMapper.romteToDomainList(response);
    } catch (e) {
      throw Exception('Failed to load chat message : $e');
    }
  }
}


class ChatLocalRepositoryImp implements ChatLocalRepository{
  final ChatLocalDataSource _localDataSource;

  ChatLocalRepositoryImp([ChatLocalDataSource? dataSource])
      : _localDataSource = dataSource ?? locator();

  @override
  Future<void> addMessage(List<ChatMessage> messages) async {
    print('addMessage 호출');

    ///TODO: return message가 필요!
    try {
      await _localDataSource.addMessages(messages);
    } catch (e) {
      throw Exception('Failed to add local chat message : $e');
    }
  }

  @override
  List<ChatMessage> getAllMessages() {
    print('getAllMessages 호출');
    try {
      final response = _localDataSource.getAllMessages();
      return ChatMapper.localToDomainList(response);
    } catch (e) {
      throw Exception('Failed to getAll local chat message : $e');
    }
  }
}