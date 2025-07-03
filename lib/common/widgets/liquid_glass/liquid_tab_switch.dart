import 'dart:math' as math;

import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class LiquidTabSwitchItem {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const LiquidTabSwitchItem({required this.label, required this.icon, required this.onTap});
}

class LiquidTabSwitch extends StatelessWidget {
  final List<LiquidTabSwitchItem> items;
  final int currentIndex;
  const LiquidTabSwitch({super.key, required this.items, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: LiquidGlassLayer(
        settings: LiquidGlassSettings(
          ambientStrength: 0.5,
          lightAngle: 0.2 * math.pi,
          glassColor: Colors.white12,
        ),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              LiquidGlass.inLayer(
                blur: 3,
                shape: LiquidRoundedSuperellipse(
                  borderRadius: const Radius.circular(40),
                ),
                glassContainsChild: false,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    spacing: 4,
                    children: items.mapIndexed(
                      (index, item) {
                        final isActive = currentIndex == index;
                        return GestureDetector(
                          onTap: item.onTap,
                          child: LiquidGlass(
                            blur: isActive ? 8 : 0,
                            settings: LiquidGlassSettings(
                              ambientStrength: isActive ? 0.5 : 0.0,
                              lightAngle: isActive ? 0.2 * math.pi : 0.0,
                              glassColor: isActive ? Colors.black26 : Colors.transparent,
                              thickness: 10,
                            ),
                            shape: LiquidRoundedSuperellipse(
                              borderRadius: const Radius.circular(40),
                            ),
                            glassContainsChild: false,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                              child: Row(
                                spacing: 4,
                                children: [
                                  Icon(
                                    item.icon,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  Text(
                                    item.label,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
