import 'package:mobile1_flutter_coding_test/index.dart';

enum UserStatus {
  online(Colors.green),
  offline(Colors.grey),
  away(Colors.yellow),
  do_not_disturb(Colors.red);

  final Color backColor;
  const UserStatus(this.backColor);
}