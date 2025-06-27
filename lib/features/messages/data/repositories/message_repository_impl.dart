import '../datasources/message_remote_datasource.dart';
import '../models/message.dart';
import 'message_repository.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessageRemoteDataSource remoteDataSource;

  MessageRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Message>> fetchMessages() {
    return remoteDataSource.fetchMessages();
  }
}
