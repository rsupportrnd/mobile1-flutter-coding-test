import 'package:flutter/material.dart';

import '../../../../common/common.dart';
import '../../../domain/domain.dart';
import '../../widgets/style_text.dart';
import 'user_status_icon.dart';

class UserInfoCard extends StatelessWidget {
  final User user;

  const UserInfoCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      child: Container(
        padding: AppDim.paddingMedium,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey, width: 0.1),
          borderRadius: UIConstants.borderLightRadius,
        ),
        child: Column(
          children: [
            _buildInfoRow(AppStrings.idTitle, user.id),
            AppDim.heightMedium,
            _buildRoleRow(),
            AppDim.heightMedium,
            _buildInfoRow(AppStrings.emailTitle, user.email),
            AppDim.heightMedium,
            _buildStatusRow(),
          ],
        ),
      ),
    );
  }

  /// 정보를 표시하는 Row
  _buildInfoRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        StyleText(
          text: title,
          fontWeight: AppDim.weightBold,
        ),
        StyleText(
          text: value,
          size: AppDim.fontSizeSmall,
        ),
      ],
    );
  }

  /// 역할 정보를 표시하는 Row
  _buildRoleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const StyleText(
          text: AppStrings.positionTitle,
          fontWeight: AppDim.weightBold,
        ),
        StyleText(
          text: user.role == UserRole.admin
              ? AppStrings.admin
              : AppStrings.member,
          size: AppDim.fontSizeSmall,
        ),
      ],
    );
  }

  /// 상태 정보를 표시하는 Row
  _buildStatusRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const StyleText(
          text: AppStrings.statusTitle,
          fontWeight: AppDim.weightBold,
        ),
        UserStatusLable(status: user.status),
      ],
    );
  }
}
