import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/widgets/platform_progress_indicator.dart';

class ProfileImage extends StatelessWidget {
  final double imageSize;
  final String? imageUrl;

  const ProfileImage({
    super.key,
    required this.imageSize,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        height: imageSize,
        width: imageSize,
        imageUrl: imageUrl!,
        placeholder: (context, url) => const PlatformProgressIndicator(),
        errorWidget: (context, url, error) =>
            Image.asset('assets/images/profile_image.png'),
      ),
    );
  }
}
