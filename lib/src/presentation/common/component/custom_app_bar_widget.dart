import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile1_flutter_coding_test/src/core/theme/app_color.dart';
import 'package:mobile1_flutter_coding_test/src/core/theme/typography.dart';

///기본기능들이 담긴 커스텀 앱바위젯
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final VoidCallback? onClosePressed;
  final Widget? leading;
  final Color backgroundColor;
  final bool showCloseIcon;
  final bool showDivider;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBackPressed,
    this.onClosePressed,
    this.backgroundColor = Colors.white,
    this.showCloseIcon = false,
    this.leading,
    this.showDivider = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: showDivider
          ? const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: AppColors.iconInactive,
                ),
              ),
            )
          : null,
      child: AppBar(
        title: Text(title),
        surfaceTintColor: Colors.transparent,
        backgroundColor: backgroundColor,
        centerTitle: true,
        titleTextStyle: AppTextStyle.h1,
        toolbarHeight: 64,
        leadingWidth: 44,
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            top: 20,
            bottom: 20,
          ),
          child: leading ??
              (context.canPop() || onBackPressed != null
                  ? IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        if (onBackPressed == null) {
                          context.pop();
                          return;
                        }
                        onBackPressed?.call();
                      },
                    )
                  : const SizedBox.shrink()),
        ),
        actions: showCloseIcon
            ? [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: IconButton(
                    icon: const Icon(Icons.exit_to_app),
                    onPressed: () {
                      if (onClosePressed == null) {
                        context.pop();
                        return;
                      }
                      onClosePressed?.call();
                    },
                  ),
                )
              ]
            : null,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}
