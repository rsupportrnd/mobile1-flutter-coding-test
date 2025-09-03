import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.3),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(text, style: textStyle),
    );
  }
}
