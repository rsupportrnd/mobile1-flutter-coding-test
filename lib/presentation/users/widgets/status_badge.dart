import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status, this.size = 16});

  final String status;
  final double size;

  @override
  Widget build(BuildContext context) {
    final iconColor = _colorOf(status);
    final iconData = _iconOf(status);
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(iconData, size: size, color: iconColor),
    );
  }

  Color _colorOf(String s) {
    switch (s) {
      case 'online':
        return Colors.green;
      case 'offline':
        return Colors.grey;
      case 'away':
        return Colors.orange;
      case 'do_not_disturb':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _iconOf(String s) {
    switch (s) {
      case 'online':
        return Icons.check_circle;
      case 'offline':
        return Icons.remove_circle_outline;
      case 'away':
        return Icons.access_time;
      case 'do_not_disturb':
        return Icons.do_not_disturb_on;
      default:
        return Icons.circle_outlined;
    }
  }
}
