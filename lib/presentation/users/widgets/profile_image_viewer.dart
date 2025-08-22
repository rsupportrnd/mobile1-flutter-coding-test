import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileImageViewer extends StatelessWidget {
  const ProfileImageViewer({
    super.key,
    required this.imageUrl,
    this.size = 200,
  });

  final String? imageUrl;
  final double size;

  static void show(
    BuildContext context, {
    required String? imageUrl,
    double size = 200,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return ProfileImageViewer(imageUrl: imageUrl, size: size);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // 배경을 탭하면 닫기
          Positioned.fill(
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(color: Colors.transparent),
            ),
          ),
          // 프로필 이미지 (동그란 형태)
          Center(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipOval(
                  child: imageUrl != null && imageUrl!.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: imageUrl!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => _buildLoadingPlaceholder(context),
                          errorWidget: (context, url, error) => _buildDefaultAvatar(context),
                          memCacheWidth: (size * 2).round(),
                          memCacheHeight: (size * 2).round(),
                        )
                      : _buildDefaultAvatar(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingPlaceholder(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultAvatar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.person,
        size: size * 0.4,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}
