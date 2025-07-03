import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class LiquidIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  const LiquidIconButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      minimumSize: Size.zero,
      child: LiquidGlassLayer(
        settings: LiquidGlassSettings(
          ambientStrength: 0.5,
          lightAngle: 0.2 * math.pi,
          glassColor: Colors.white12,
        ),
        child: LiquidGlass.inLayer(
          blur: 3,
          shape: LiquidRoundedSuperellipse(
            borderRadius: const Radius.circular(40),
          ),
          glassContainsChild: false,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
