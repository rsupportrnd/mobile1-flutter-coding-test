import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/shared/enum/role_type.dart';
import 'package:mobile1_flutter_coding_test/shared/enum/user_status.dart';

class Tag extends StatelessWidget {
  const Tag(
      {super.key,
      required this.text,
      required this.color,
      required this.textStyle});
  final String text;
  final Color color;
  final TextStyle textStyle;

  factory Tag.fromUserStatus(UserStatus status) {
    return Tag(
      text: status.displayText,
      color: status.color.withValues(alpha: 0.1),
      textStyle: TextStyle(color: status.color),
    );
  }

  factory Tag.fromRoleType(RoleType role) {
    return Tag(
      text: role.displayText,
      color: role.color.withValues(alpha: 0.1),
      textStyle: TextStyle(color: role.color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        border: Border.all(color: color, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text, style: textStyle),
    );
  }
}
