import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class LiquidTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  const LiquidTextField({super.key, this.controller, this.focusNode, this.hintText});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: LiquidGlass(
            blur: 4,
            settings: LiquidGlassSettings(
              ambientStrength: 2,
              lightAngle: 0.4 * math.pi,
              glassColor: Colors.black12,
              thickness: 30,
            ),
            shape: LiquidRoundedSuperellipse(
              borderRadius: const Radius.circular(40),
            ),
            glassContainsChild: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  hintText: hintText,
                  isDense: true,
                  hintStyle: TextStyle(
                    color: Colors.white60,
                    fontSize: 14,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
