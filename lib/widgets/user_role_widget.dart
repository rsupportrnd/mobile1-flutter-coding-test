import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/commons/enums.dart';

class UserRoleWidget extends StatelessWidget {
  const UserRoleWidget({super.key, required this.userRole});

  final UserRole userRole;

  @override
  Widget build(BuildContext context) {
    if ( userRole == UserRole.admin) {
      return const Icon(Icons.handyman, color: Colors.blueGrey);
    }

    return const SizedBox.shrink();
  }
}
