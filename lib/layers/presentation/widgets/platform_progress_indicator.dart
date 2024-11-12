
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformProgressIndicator extends StatelessWidget {
  const PlatformProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? const Center(
        child: SizedBox(
            height: 40.0,
            width: 40.0,
            child: CircularProgressIndicator(strokeWidth: 2)))
        : const Center(
      child: SizedBox(
          height: 40.0,
          width: 40.0,
          child: CupertinoActivityIndicator(radius: 15)),
    );
  }
}
