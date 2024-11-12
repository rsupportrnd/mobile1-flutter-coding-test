import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'platform_progress_indicator.dart';

class ExtendedImageWidget extends StatelessWidget {
  final String url;
  final double size;

  const ExtendedImageWidget({
    super.key,
    required this.url,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      url,
      width: size,
      height: size,
      fit: BoxFit.fill,
      cache: true,
      shape: BoxShape.circle,
      borderRadius: const BorderRadius.all(Radius.circular(30.0)),
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return const PlatformProgressIndicator();
          case LoadState.completed:
            return ExtendedRawImage(
              image: state.extendedImageInfo?.image,
              width: 50,
              height: 50,
            );
            break;
          case LoadState.failed:
            return GestureDetector(
              child: Image.asset(
                'assets/images/profile_image.png',
                fit: BoxFit.fill,
              ),
              onTap: () {
                state.reLoadImage();
              },
            );
            break;
        }
      },
    );
  }
}
