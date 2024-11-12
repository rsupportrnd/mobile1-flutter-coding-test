import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/main/main_frame_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../../common/constant/app_colors.dart';
import '../../../../common/constant/app_dimensions.dart';
import '../../../domain/domain.dart';
import '../../widgets/style_text.dart';

/// BottomNavigationBar 아이템 아이콘
class NavigationBarItemIcon extends StatelessWidget {
  final TabItemType type;

  const NavigationBarItemIcon({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MainFrameViewModel>(
      builder: (context, provider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ColorFiltered(
              colorFilter: provider.selectedIndex == type.itemIndex
                  ? ColorFilter.mode(AppColors.primary, BlendMode.srcIn)
                  : ColorFilter.mode(AppColors.textGrey, BlendMode.srcIn),
              child: Icon(type.icon, size: AppDim.iconMedium),
            ),
            StyleText(
              text: type.label,
              align: TextAlign.center,
              color: provider.selectedIndex == type.itemIndex
                  ? AppColors.primary
                  : AppColors.textGrey,
              size: AppDim.fontSizeSmall,
              maxLinesCount: 2,
            )
          ],
        );
      },
    );
  }
}
