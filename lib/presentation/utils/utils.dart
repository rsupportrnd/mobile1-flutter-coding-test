import 'package:intl/intl.dart';
import 'package:mobile1_flutter_coding_test/domain/entity/message.dart';
import 'package:mobile1_flutter_coding_test/presentation/utils/my_logger.dart';

class Utils {
  factory Utils() => _instance;
  static final Utils _instance = Utils._internal();
  Utils._internal() {
    // initCode
  }

  String formatMessageTime(String timeStamp) {
    final now = DateTime.now();
    final utcDate = DateTime.parse(timeStamp);
    final date = utcDate.toLocal(); // Z(UTC) → 로컬 시간 변환

    final today = DateTime(now.year, now.month, now.day);
    final messageDay = DateTime(date.year, date.month, date.day);
    final diff = today.difference(messageDay).inDays;

    if (diff == 0) {
      // 오늘
      return DateFormat('a h:mm').format(date); // 오전/오후 0:00
    } else if (diff == 1) {
      // 어제
      return '어제';
    } else if (date.year == now.year) {
      // 올해
      return DateFormat('M월 d일').format(date); // 11월 7일
    } else {
      // 작년 이전
      return DateFormat('yyyy.MM.dd').format(date); // 2023.11.07
    }
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
        timestamp: DateTime.now().toLocal().toIso8601String().split('.').first);
  }
}
