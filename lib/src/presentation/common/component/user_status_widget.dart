import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/src/core/common/enum/user_enum.dart';

class UserStatusWidget extends StatelessWidget {
  final UserStatus userStatus;
  const UserStatusWidget({
    super.key,
    required this.userStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: userStatus.getStatusColor(),
        border: Border.all(color: Colors.white, width: 2),
      ),
    );
  }
}
