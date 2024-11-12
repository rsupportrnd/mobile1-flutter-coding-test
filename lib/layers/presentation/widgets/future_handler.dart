import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/widgets/style_text.dart';

import '../../../common/common.dart';

class FutureHandler extends StatelessWidget {
  final bool isLoading;
  final bool isError;
  final String errorMessage;
  final VoidCallback onRetry; // 재시도할 때 호출되는 콜백 함수
  final Widget child;

  const FutureHandler({
    super.key,
    required this.isLoading,
    required this.isError,
    required this.onRetry,
    required this.errorMessage,
    required this.child,
  });

  double get indicatorSize => 35.0;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Platform.isAndroid
          ? Center(
          child: SizedBox(
              height: indicatorSize,
              width: indicatorSize,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: AppColors.primary,
              )))
          :  Center(
        child: SizedBox(
            height: indicatorSize,
            width: indicatorSize,
            child: const CupertinoActivityIndicator(radius: 15)),
      );
    } else if (isError) {
      // 에러가 발생했을 때 에러 메시지와 재시도 버튼을 표시
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: AppDim.iconXLarge,
              color: Colors.redAccent,
            ),
            const Gap(AppDim.small),
            StyleText(
              text: errorMessage,
              maxLinesCount: 3,
              align: TextAlign.center,
            ),
            const Gap(AppDim.large),
            InkWell(
              onTap: onRetry,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: AppDim.xSmall, horizontal: AppDim.small),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  border: Border.all(color: AppColors.textGrey, width: 1.5),
                  borderRadius: BorderRadius.all(UIConstants.radius),
                ),
                child:  const StyleText(
                  text: AppStrings.retry,
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return child;
    }
  }
}
