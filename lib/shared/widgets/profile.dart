import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key, required this.imageUrl, this.radius = 20});
  final String imageUrl;
  final double radius;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey,
      child: ClipOval(
        child: Image.network(
          width: radius * 2,
          height: radius * 2,
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.person,
              color: Colors.white,
              size: 20,
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 1,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }
}
