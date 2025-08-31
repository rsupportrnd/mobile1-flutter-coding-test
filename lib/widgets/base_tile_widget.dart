import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BaseTileWidget extends StatelessWidget {
  const BaseTileWidget({super.key, this.onTap, this.thumbnailPath, required this.content});

  final VoidCallback? onTap;
  final String? thumbnailPath;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 75,
          child: Row(
            children: [
              SizedBox(
                  width: 75,
                  height: 75,
                  child: Center(
                    child: (thumbnailPath != null) ?
                    Container(
                        width: 50,
                        height: 50,
                        decoration:
                        BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.transparent,
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  thumbnailPath!,
                                  maxWidth: 50,
                                  maxHeight: 50,
                                  errorListener: (_) {

                                  })),
                        )) : const Icon(Icons.account_circle, size: 50, color: Colors.grey),
                  )),
              Expanded(child: content),
            ],
          )),
    );
  }
}
