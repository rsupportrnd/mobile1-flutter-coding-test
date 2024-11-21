import 'package:mobile1_flutter_coding_test/index.dart';

enum UserStatus {
  all(Colors.white),
  online(Colors.green),
  offline(Colors.grey),
  away(Colors.yellow),
  do_not_disturb(Colors.red);

  final Color backColor;
  const UserStatus(this.backColor);
}

const double INPUTBOX_HEIGHT = 66;