import 'package:intl/intl.dart';

class FormatHelpers {
  static final DateFormat _timeFormatter = DateFormat('HH:mm');
  static final DateFormat _dateFormatter = DateFormat('MM/dd');

  static String formatMessageTime(DateTime dateTime) {
    return _timeFormatter.format(dateTime);
  }

  static String formatDate(DateTime dateTime) {
    return _dateFormatter.format(dateTime);
  }

  static String formatSmartDate(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (messageDate == today) {
      return formatMessageTime(dateTime);
    } else if (messageDate == yesterday) {
      return '어제';
    } else {
      return formatDate(dateTime);
    }
  }

  static String formatMessageCount(int count) {
    if (count > 99) {
      return '99+';
    } else {
      return count.toString();
    }
  }
} 