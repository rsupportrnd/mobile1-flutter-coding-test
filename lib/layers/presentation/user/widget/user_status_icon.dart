import 'package:flutter/material.dart';

import '../../../../common/common.dart';
import '../../../domain/domain.dart';
import '../../widgets/style_text.dart';

class UserStatusLable extends StatelessWidget {
  final UserStatus status;

  const UserStatusLable({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    String statueText = '';
    Color textColor = Colors.black;

    // 상태에 따른 아이콘 및 색상 매핑
    switch (status) {
      case UserStatus.online:
        statueText = AppStrings.onlineLabel;
        textColor = Colors.green;
        break;
      case UserStatus.offline:
        statueText = AppStrings.offlineLabel;
        textColor = Colors.grey;
        break;
      case UserStatus.away:
        statueText = AppStrings.awayLabel;
        textColor = Colors.orange;
        break;
      case UserStatus.doNotDisturb:
        statueText = AppStrings.doNotDisturbLabel;
        textColor = Colors.red;
        break;
    }

    return StyleText(
      text: '● $statueText',
      color: textColor,
      size: AppDim.fontSizeXSmall,
      fontWeight: FontWeight.bold,
    );
  }
}
