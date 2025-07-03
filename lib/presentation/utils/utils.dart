import 'package:mobile1_flutter_coding_test/domain/entity/message.dart';

class Utils {
  factory Utils() => _instance;
  static final Utils _instance = Utils._internal();
  Utils._internal() {
    // initCode
  }

  Message makeMessage(
      {required String sender,
      required String content,
      required String roomId}) {
    return Message(
        content: content,
        messageId: "",
        roomId: roomId,
        sender: sender,
        timestamp: DateTime.now().toUtc().toIso8601String());
  }
}
