import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String toYYYYMMDDHHMM() {
    return DateFormat('yyyy-MM-dd HH:mm').format(this);
  }

  String toDiffTime() {
    final now = DateTime.now();
    final diff = now.difference(this);
    if (diff.inDays > 0) {
      return '${diff.inDays}일 전';
    }
    if (diff.inHours > 0) {
      return '${diff.inHours}시간 전';
    }
    if (diff.inMinutes > 0) {
      return '${diff.inMinutes}분 전';
    }
    return '${diff.inSeconds}초 전';
  }
}
