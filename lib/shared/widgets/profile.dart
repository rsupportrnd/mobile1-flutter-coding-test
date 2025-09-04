import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
        child: CachedNetworkImage(
          width: radius * 2,
          height: radius * 2,
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => Icon(
            Icons.person,
            color: Colors.white,
            size: radius * 0.8,
          ),
          errorWidget: (context, url, error) => Icon(
            Icons.person,
            color: Colors.white,
            size: radius * 0.8,
          ),
        ),
      ),
    );
  }
}
