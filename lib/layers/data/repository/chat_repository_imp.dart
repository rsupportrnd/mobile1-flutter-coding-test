import 'package:mobile1_flutter_coding_test/common/common.dart';

import '../../domain/domain.dart';
import '../data.dart';

class ChatRepositoryImp implements ChatRepository {
  final RemoteDataSources _remoteDataSource;

  ChatRepositoryImp([RemoteDataSources? dataSource])
      : _remoteDataSource = dataSource ?? locator();

  @override
  Future<List<ChatMessage>> fetchChatMessage() async {
    try {
      final response = await _remoteDataSource.fetchChatMessage();
      return ChatMapper.toDomainList(response);
    } catch (e) {
      throw Exception('Failed to load chat message : $e');
    }
  }
}
