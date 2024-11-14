import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/common/common.dart';

import '../../widgets/platform_progress_indicator.dart';

class MeetingRoomImage extends StatelessWidget {
  final double imageSize;
  final String? imageUrl;

  const MeetingRoomImage({
    super.key,
    required this.imageSize,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return  ClipRRect(
      borderRadius: UIConstants.borderMediumRadius, // 원하는 radius 값으로 조정
      child: CachedNetworkImage(
        height: imageSize,
        width: imageSize,
        imageUrl: imageUrl!,
        placeholder: (context, url) => const PlatformProgressIndicator(),
        errorWidget: (context, url, error) =>
            Image.asset('assets/images/meeting_room.jpg'),
      ),
    );
  }
}