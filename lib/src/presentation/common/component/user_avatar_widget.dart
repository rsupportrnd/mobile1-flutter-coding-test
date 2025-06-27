import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/src/core/constant/image_path_constant.dart';

class UserAvatarWidget extends StatelessWidget {
  final String profilePictureUrl;
  const UserAvatarWidget({
    super.key,
    required this.profilePictureUrl,
  });

  @override
  Widget build(BuildContext context) {
    const double imageSize = 56;
    return ClipOval(
      child: Image.network(
        profilePictureUrl,
        width: imageSize,
        height: imageSize,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Image.asset(
            ImagePath.defaultProfile,
            width: imageSize,
            height: imageSize,
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            ImagePath.defaultProfile,
            width: imageSize,
            height: imageSize,
          );
        },
      ),
    );
  }
}
