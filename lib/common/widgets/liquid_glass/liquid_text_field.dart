import 'dart:ui';
import 'package:flutter/material.dart';

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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(40),
                ),
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
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
