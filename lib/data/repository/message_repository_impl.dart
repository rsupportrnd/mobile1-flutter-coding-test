import 'package:mobile1_flutter_coding_test/data/datasource/message_datasource.dart';
import 'package:mobile1_flutter_coding_test/data/mapper/message_mapper.dart';
import 'package:mobile1_flutter_coding_test/data/utils/safe_call.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/message.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/result.dart';
import 'package:mobile1_flutter_coding_test/domain/repository/message_repository.dart';

class MessageRepositoryImpl implements MessageRepository {
  MessageRepositoryImpl({required MessageDataSource dataSource})
      : _dataSource = dataSource;
  final MessageDataSource _dataSource;

  @override
  Future<Result<List<Message>>> getMessages() async {
    return await safeCall(() async {
      final response = await _dataSource.getMessages();
      return response.messages.map((element) => element.toEntity()).toList();
    });
  }
}
