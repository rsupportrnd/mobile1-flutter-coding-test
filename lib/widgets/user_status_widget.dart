import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/commons/enums.dart';

class UserStatusWidget extends StatelessWidget {
  const UserStatusWidget({super.key, required this.userStatus});

  final UserStatus userStatus;

  @override
  Widget build(BuildContext context) {

    switch ( userStatus ) {
      case UserStatus.offline:
        return const Icon(Icons.offline_bolt_outlined, color: Colors.grey);
      case UserStatus.online:
        return const Icon(Icons.offline_bolt_outlined, color: Colors.green);
      case UserStatus.doNotDisturb:
        return const Icon(Icons.do_not_disturb_on, color: Colors.red);
      case UserStatus.away:
        return const Icon(Icons.close, color: Colors.grey);
      default:
    }

    return const SizedBox.shrink();
  }
}
