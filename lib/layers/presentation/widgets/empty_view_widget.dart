import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/widgets/style_text.dart';

import '../../../common/common.dart';

/// 데이터가 없을 때 보여주는 뷰 위젯
class EmptyViewWidget extends StatelessWidget {

  /// 이미지 경로
  final String imagePath;

  /// 내용
  final String content;

  const EmptyViewWidget({
    super.key,
    required this.imagePath,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: AppDim.imageSmallMedium,
            height: AppDim.imageSmallMedium,
          ),
          const Gap(AppDim.medium),
          StyleText(
            text: content,
            color: AppColors.textBlack,
          ),
        ],
      ),
    );
  }
}
