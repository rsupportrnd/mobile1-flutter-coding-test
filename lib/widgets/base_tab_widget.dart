import 'package:flutter/material.dart';

class BaseTabWidget extends StatelessWidget {
  const BaseTabWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: child
      ),
    );
  }
}