import 'package:mobile1_flutter_coding_test/data/model/response.dart';

abstract class MessageDataSource {
  Future<MessageResponse> getMessages();
}
