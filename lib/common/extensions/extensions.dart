import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String toYYYYMMDDHHMM() {
    return DateFormat('yyyy-MM-dd HH:mm').format(this);
  }
}
