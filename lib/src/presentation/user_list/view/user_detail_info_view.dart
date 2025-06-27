import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile1_flutter_coding_test/src/core/constant/string_constant/user_list_string_constant.dart';
import 'package:mobile1_flutter_coding_test/src/core/theme/typography.dart';
import 'package:mobile1_flutter_coding_test/src/domain/entity/user_list_response_entity.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/common/base/base_view.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/common/component/user_avatar_widget.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/common/component/user_status_widget.dart';

class UserDetailInfoView extends BaseView {
  final UserEntity userEntity;

  const UserDetailInfoView({
    super.key,
    required this.userEntity,
  });

  @override
  Widget buildView(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          UserAvatarWidget(profilePictureUrl: userEntity.profilePicture),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UserStatusWidget(userStatus: userEntity.status),
              const SizedBox(width: 8),
              Text(
                userEntity.status.getStatusName(),
                style: AppTextStyle.body
                    .copyWith(color: userEntity.status.getStatusColor()),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            userEntity.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            userEntity.email,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Text(
            '${UserListStringConstant.userRole}: ${userEntity.role.getRoleName()}',
            style: AppTextStyle.body,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
