import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  final String url;
  final double size;

  const UserProfile.large({super.key, required this.url}) : size = 40;
  const UserProfile.small({super.key, required this.url}) : size = 20;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Image.network(
        url,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.person);
        },
      ),
    );
  }
}
