import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  bool get isThisWeek {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));

    return isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
        isBefore(endOfWeek.add(const Duration(days: 1)));
  }

  bool get isThisYear {
    return year == DateTime.now().year;
  }

  String get chatDisplayTime {
    if (isToday) {
      return DateFormat('a h:mm', 'ko').format(this);
    } else if (isYesterday) {
      return '어제';
    } else if (isThisWeek) {
      return DateFormat('EEEE', 'ko').format(this);
    } else if (isThisYear) {
      return DateFormat('M월 d일', 'ko').format(this);
    } else {
      return DateFormat('yy.MM.dd', 'ko').format(this);
    }
  }
}
