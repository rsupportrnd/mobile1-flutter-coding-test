import 'package:mobile1_flutter_coding_test/data/model/message_model.dart';

abstract class LocalDatabaseDataSource {
  Future<List<MessageModel>> getMessage();
  Future<void> insertMessage({required MessageModel message});
}
