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
    return ClipOval(
      child: FadeInImage.assetNetwork(
        placeholder: ImagePath.defaultProfile,
        image: profilePictureUrl,
        width: 56,
        height: 56,
        fit: BoxFit.cover,
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.network(
            profilePictureUrl,
            width: 56,
            height: 56,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                ImagePath.defaultProfile,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
              );
            },
          );
        },
      ),
    );
  }
}
