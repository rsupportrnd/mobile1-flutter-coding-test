import 'package:intl/intl.dart';


class Etc {
  /// 채팅 메시지 생성 날짜
  static chatTimeAgoDisplay(DateTime? targetDate){
    final now = DateTime.now();
    final difference = now.difference(targetDate?? now);

    if (difference.inSeconds < 60) {
      return DateFormat('a hh:mm', 'ko_KR').format(targetDate?? now);
    } else if (difference.inMinutes < 60) {
      return DateFormat('a hh:mm', 'ko_KR').format(targetDate?? now);
    } else if (difference.inHours < 24) {
      return DateFormat('a hh:mm', 'ko_KR').format(targetDate?? now);
    } else if (difference.inDays < 10) {
      return '${difference.inDays}일 전';
    } else if (difference.inDays < 30) {
      return DateFormat('MM. dd.').format(targetDate?? now);
    } else if (difference.inDays < 60) {
      return '1개월 전';
    } else if (difference.inDays < 180) {
      final monthsAgo = (difference.inDays / 30).floor();
      return '$monthsAgo개월 전';
    } else {
      return DateFormat('yyyy. MM. dd.').format(targetDate?? now);
    }
  }
}