import 'package:mobile1_flutter_coding_test/app/index.dart';

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
