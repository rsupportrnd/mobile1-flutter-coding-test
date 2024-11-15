import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/chat/chat_view.dart';

import '../../../../common/common.dart';
import '../../../domain/domain.dart';
import '../../widgets/style_text.dart';
import 'meeting_room_image.dart';

class MeetingRoomTile extends StatelessWidget {
  final MeetingRoom meetingRoom;

  const MeetingRoomTile({
    super.key,
    required this.meetingRoom,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Nav.doPush(context, ChatView(title: meetingRoom.roomName));
      },
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
                _buildThumbnailImage(),
                AppDim.widthSmall,
                _buildMeetingRoomSummary(),
              ],
            ),
            _buildTimestamp(),
          ],
        ),
      ),
    );
  }

  /// 마지막 메시지 시간
  _buildTimestamp() {
    return StyleText(
      text: '${Etc.chatTimeAgoDisplay(meetingRoom.lastMessage.timestamp)}',
      size: AppDim.fontSizeSmall,
    );
  }

  /// 회의방 요약
  _buildMeetingRoomSummary() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// 회의 방 이름
            StyleText(
              text: meetingRoom.roomName,
              size: AppDim.fontSizeLarge,
            ),
            AppDim.widthXSmall,

            /// 회의방 인원수
            StyleText(
              text: meetingRoom.participants.length.toString(),
              size: AppDim.fontSizeMedium,
              color: AppColors.grey,
            ),
          ],
        ),

        /// 마지막 메시지 내용
        StyleText(
          text: meetingRoom.lastMessage.content,
          size: AppDim.fontSizeXSmall,
        ),
      ],
    );
  }

  /// 썸네일 이미지
  _buildThumbnailImage() {
    return Card(
      elevation: UIConstants.elevation2,
      shape: RoundedRectangleBorder(borderRadius: UIConstants.borderMediumRadius),
      child: Container(
          padding: AppDim.paddingXxSmall,
          child: MeetingRoomImage(
            imageSize: AppDim.imageSmallMedium,
            imageUrl: meetingRoom.thumbnailImage,
          ),
      ),
    );
  }
}
