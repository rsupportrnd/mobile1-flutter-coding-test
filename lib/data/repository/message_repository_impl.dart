import 'package:mobile1_flutter_coding_test/data/datasource/local_database_datasource.dart';
import 'package:mobile1_flutter_coding_test/data/datasource/message_datasource.dart';
import 'package:mobile1_flutter_coding_test/data/mapper/message_mapper.dart';
import 'package:mobile1_flutter_coding_test/data/utils/safe_call.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/message.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/result.dart';
import 'package:mobile1_flutter_coding_test/domain/repository/message_repository.dart';

class MessageRepositoryImpl implements MessageRepository {
  MessageRepositoryImpl(
      {required MessageDataSource dataSource,
      required LocalDatabaseDataSource localDatabaseDataSource})
      : _dataSource = dataSource,
        _localDatabaseDataSource = localDatabaseDataSource;
  final MessageDataSource _dataSource;
  final LocalDatabaseDataSource _localDatabaseDataSource;

  @override
  Future<Result<List<Message>>> getMessages() async {
    return await safeCall(() async {
      final response = await _dataSource.getMessages();
      final result =
          response.messages.map((element) => element.toEntity()).toList();
      await insertMessages(messages: result);
      return result;
    });
  }

  @override
  Future<Result<List<Message>>> selectMessages({required String roomId}) async {
    return await safeCall(() async {
      final response =
          await _localDatabaseDataSource.selectMessages(roomId: roomId);
      return response.map((element) => element.toEntity()).toList();
    });
  }

  @override
  Future<Result<Message>> insertMessage({required Message message}) async {
    return await safeCall(() async {
      final resposne = await _localDatabaseDataSource.insertMessage(
          message: message.toModel());
      return resposne.toEntity();
    });
  }

  @override
  Future<Result<void>> insertMessages({required List<Message> messages}) async {
    return await safeCall(() async {
      await _localDatabaseDataSource.insertMessages(
          messages: messages.map((element) => element.toModel()).toList());
    });
  }
}
