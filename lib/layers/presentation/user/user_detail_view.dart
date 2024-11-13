import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/user/widget/user_info_card.dart';
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
            /// 프로필 이미지
            ProfileImage(
              imageSize: AppDim.imageLarge,
              imageUrl: user.profilePictureUrl,
            ),
            AppDim.heightMedium,

            /// 유저 이름
            StyleText(
                text: user.name,
                size: AppDim.fontSizeLarge,
                fontWeight: FontWeight.bold,
            ),
            AppDim.heightMediumLarge,

            /// 유저 정보
            UserInfoCard(user: user),
          ],
        ),
      ),
    );
  }
}
