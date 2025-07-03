import 'dart:ui';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';

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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(40),
            ),
            child: AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 4,
                  children: items.mapIndexed(
                    (index, item) {
                      final isActive = currentIndex == index;
                      return GestureDetector(
                        onTap: item.onTap,
                        behavior: HitTestBehavior.opaque,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: isActive ? 8 : 0,
                              sigmaY: isActive ? 8 : 0,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isActive ? Colors.black26 : Colors.transparent,
                                borderRadius: BorderRadius.circular(40),
                              ),
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
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
