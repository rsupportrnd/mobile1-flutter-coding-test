import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          placeholder: (context, url) => _buildLoadingPlaceholder(),
          errorWidget: (context, url, error) => _fallback(),
          memCacheWidth: (size * 2).round(),
          memCacheHeight: (size * 2).round(),
        ),
      ),
    );
  }

  Widget _buildLoadingPlaceholder() {
    return Container(
      color: Colors.grey[300],
      child: Center(
        child: SizedBox(
          width: size * 0.3,
          height: size * 0.3,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[600]!),
          ),
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


