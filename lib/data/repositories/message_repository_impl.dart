import 'package:mobile1_flutter_coding_test/data/datasources/user_local_datasource.dart';
import 'package:mobile1_flutter_coding_test/data/datasources/user_remote_datasource.dart';
import 'package:mobile1_flutter_coding_test/domain/entities/message_entity.dart';
import 'package:mobile1_flutter_coding_test/domain/repositories/message_repository.dart';

class MessageRepositoryImpl implements MessageRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;

  MessageRepositoryImpl({required this.remoteDataSource, required this.localDataSource});

  @override
  Future<List<MessageEntity>> getMessages() async {
    final localMessages = await localDataSource.getMessages();
    if (localMessages.isNotEmpty) {
      return localMessages.map((e) => MessageEntity.fromModel(e)).toList();
    }

    final model = await remoteDataSource.getMessages();
    await localDataSource.saveMessages(model);
    return model.map((e) => MessageEntity.fromModel(e)).toList();
  }

  @override
  Future<MessageEntity> postMessage(MessageEntity message) async {
    final model = await localDataSource.postMessage(message.toModel());
    return MessageEntity.fromModel(model);
  }
}
