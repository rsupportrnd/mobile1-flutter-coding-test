import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/src/core/theme/app_color.dart';

class UserAvatarWidget extends StatelessWidget {
  final String profilePictureUrl;
  const UserAvatarWidget({
    super.key,
    required this.profilePictureUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
        profilePictureUrl,
        width: 56,
        height: 56,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: AppColors.iconInactive,
            child: const Icon(
              Icons.person_outline_sharp,
              size: 56,
            ),
          );
        },
      ),
    );
  }
}
