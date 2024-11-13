import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/user/user_detail_view.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/user/widget/user_status_icon.dart';

import '../../../../common/common.dart';
import '../../../domain/domain.dart';
import '../../widgets/circle_avatar_widget.dart';
import '../../widgets/style_text.dart';

class UserTile extends StatelessWidget {
  final User user;

  const UserTile({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Nav.doPush(context, UserDetailView(user: user)),
      child: Container(
        height: UIConstants.tileHeight90,
        padding: AppDim.paddingXSmall,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// 프로필 이미지
                Card(
                  elevation: UIConstants.elevation2,
                  shape: RoundedRectangleBorder(borderRadius: UIConstants.borderCircle),
                  child: Container(
                      padding:  AppDim.paddingXxSmall,
                      child: ProfileImage(
                        imageSize: AppDim.imageSmallMedium,
                        imageUrl: user.profilePictureUrl,
                      )
                      ),
                ),
                AppDim.widthSmall,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [

                        /// 관리자 아이콘
                        Visibility(
                          visible: user.role == UserRole.admin,
                          child: const Row(
                            children: [
                              Icon(
                                Icons.verified_user,
                                size: AppDim.iconXSmall,
                                color: Colors.blue,
                              ),
                              AppDim.widthXSmall,
                            ],
                          ),
                        ),

                        /// 이름
                        StyleText(
                          text: user.name,
                          size: AppDim.fontSizeLarge,
                        ),
                        AppDim.widthSmall,

                        /// 상태 아이콘
                        UserStatusLable(status: user.status),
                      ],
                    ),


                    /// 이메일
                    StyleText(
                      text: user.email,
                      size: AppDim.fontSizeXSmall,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
