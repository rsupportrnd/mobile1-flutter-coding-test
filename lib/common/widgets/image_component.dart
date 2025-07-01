import 'package:flutter/material.dart';

class ImageComponent extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;

  const ImageComponent({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit,
    this.errorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) => SizedBox(
          width: width,
          height: height,
          child: errorBuilder?.call(context, error, stackTrace) ??
              const Center(child: Icon(Icons.broken_image))),
    );
  }
}
