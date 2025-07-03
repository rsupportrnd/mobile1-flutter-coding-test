import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/common/widgets/image_component.dart';
import 'package:mobile1_flutter_coding_test/common/widgets/liquid_glass/liquid_icon_button.dart';

class LiquidAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const LiquidAppBar({super.key, required this.title});

  @override
  Size get preferredSize => Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).scaffoldBackgroundColor,
            Colors.transparent,
          ],
        ),
      ),
      child: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            children: [
              Row(
                children: [
                  Builder(builder: (context) {
                    final canBack = context.router.canPop();

                    if (canBack) {
                      return LiquidIconButton(
                        icon: CupertinoIcons.arrow_left,
                        onPressed: context.router.pop,
                      );
                    }

                    return ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ClipOval(
                              child: Builder(builder: (context) {
                                return ImageComponent(
                                  width: 34,
                                  height: 34,
                                  url:
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSU96DCqDv4rO3TBYTT8l3eKF_GqHrrcHeDIw&s',
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '알서포트',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: Colors.white60,
                            size: 16,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            title,
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
