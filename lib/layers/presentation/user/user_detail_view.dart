import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/user/widget/user_status_icon.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/widgets/circle_avatar_widget.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/widgets/frame_scaffold.dart';

import '../../../common/common.dart';
import '../../domain/domain.dart';
import '../widgets/style_text.dart';

class UserDetailView extends StatelessWidget {
  final User user;

  const UserDetailView({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return FrameScaffold(
        appBarTitle: ' ',
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ProfileImage(
                  imageSize: AppDim.imageLarge,
                  imageUrl: user.profilePictureUrl,
              ),
              AppDim.heightMedium,
              StyleText(text: user.name, size: AppDim.fontSizeLarge, fontWeight: FontWeight.bold),
              AppDim.heightMediumLarge,

              Card(
                color: AppColors.white,
                child: Container(
                  padding: AppDim.paddingMedium,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.grey, width: 0.1),
                    borderRadius: UIConstants.borderLightRadius,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const StyleText(text: 'ID', fontWeight: AppDim.weightBold),
                          StyleText(text: user.id, size: AppDim.fontSizeSmall),
                        ],
                      ),
                      AppDim.heightMedium,

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const StyleText(text: '직급', fontWeight: AppDim.weightBold),
                          StyleText(text: user.role == UserRole.admin ? '관리자' : '팀원',size: AppDim.fontSizeSmall),
                        ],
                      ),
                      AppDim.heightMedium,


                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const StyleText(text: '이메일', fontWeight: AppDim.weightBold),
                          StyleText(text: user.email, size: AppDim.fontSizeSmall),
                        ],
                      ),
                      AppDim.heightMedium,
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const StyleText(text: '상태', fontWeight: AppDim.weightBold),
                          UserStatusLable(status: user.status)
                        ],
                      ),
                    ],
                  ),
                ),
              )

            ],
          ),
        ));
  }
}
