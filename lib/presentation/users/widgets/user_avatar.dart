import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, required this.url, this.size = 48, this.iconSize = 24});

  final String url;
  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return _fallback();
    }
    return ClipOval(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: Colors.grey[300]),
        child: Image.network(
          url,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _fallback(),
        ),
      ),
    );
  }

  Widget _fallback() {
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: Colors.grey[300],
      child: Icon(Icons.person, size: iconSize, color: Colors.grey[600]),
    );
  }
}


