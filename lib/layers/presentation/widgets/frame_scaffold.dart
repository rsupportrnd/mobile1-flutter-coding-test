import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/widgets/style_text.dart';

import '../../../common/common.dart';

class FrameScaffold extends StatelessWidget {
  final Widget body;
  final String? appBarTitle;
  final Widget? bottomNavigationBar;
  final bool isKeyboardHide;
  final bool isDefaultPadding;

  const FrameScaffold({
    super.key,
    this.appBarTitle,
    this.isKeyboardHide = false,
    required this.body,
    this.bottomNavigationBar,
    this.isDefaultPadding = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {if (isKeyboardHide) KeyboardUtil.hide(context)},
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: appBarTitle == ''
            ? null
            : AppBar(
                title: StyleText(text: appBarTitle ?? ''),
                centerTitle: true,
                backgroundColor: AppColors.background,
                iconTheme: IconThemeData(color: AppColors.primary),
                elevation: 0.0,
              ),
        body: SafeArea(
          child: Container(
            padding: isDefaultPadding
                ? AppDim.paddingMedium
                : EdgeInsets.zero,
            child: body,
          ),
        ),
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
