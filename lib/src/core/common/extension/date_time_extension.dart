import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get updateLastMessageDateFormat {
    final DateTime now = DateTime.now();

    if (year == now.year) {
      if (month == now.month && day == now.day) {
        return DateFormat('HH:mm').format(this);
      } else {
        return DateFormat('MM.dd').format(this);
      }
    } else {
      return DateFormat('yy.MM').format(this);
    }
  }
}
