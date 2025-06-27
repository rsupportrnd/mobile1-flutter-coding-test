import '../datasources/message_remote_datasource.dart';
import '../datasources/message_local_datasource.dart';
import '../models/message.dart';
import 'message_repository.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessageRemoteDataSource remoteDataSource;
  final MessageLocalDataSource localDataSource;

  MessageRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<Message>> fetchMessages() async {
    try {
      return await remoteDataSource.fetchMessages();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveMessage(Message message) async {
    await localDataSource.saveMessage(message);
  }

  @override
  Future<List<Message>> getLocalMessagesByRoom(String roomId) async {
    return await localDataSource.getMessagesByRoom(roomId);
  }
}
