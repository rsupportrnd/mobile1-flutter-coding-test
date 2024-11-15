import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/common/common.dart';
import 'package:mobile1_flutter_coding_test/layers/presentation/meeting/meeting_room_list_viewmodel.dart';
import 'package:provider/provider.dart';

import '../chat_viewmodel.dart';

class TextComposer extends StatelessWidget {
  const TextComposer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatViewModel>(context, listen: false);
    final meetingViewModel = Provider.of<MeetingRoomListViewModel>(context, listen: false);

    return Container(
      padding: const EdgeInsets.only(top: AppDim.xSmall),
      child: Row(
        children: [
          _buildTextField(context, provider),
          _buildSendButton(provider, meetingViewModel),
        ],
      ),
    );
  }

  _buildTextField(BuildContext context, ChatViewModel provider) {
    return Expanded(
      child: Container(
        height: UIConstants.textFieldHeight50,
        margin: const EdgeInsets.only(left: AppDim.small),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: UIConstants.borderMediumRadius,
          ),
          color: Colors.grey.shade200,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDim.medium),
              child: MediaQuery(
                data: Etc.getScaleFontSize(context, fontSize: 0.9),
                child: TextField(
                  controller: provider.chatComposerController,
                  // ViewModel의 컨트롤러 사용
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 20,
                  textInputAction: TextInputAction.done,
                  onChanged: (value) {},
                  decoration: const InputDecoration.collapsed(
                    hintText: '메시지 보내기',
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildSendButton(ChatViewModel provider, MeetingRoomListViewModel meetingViewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDim.xSmall),
      child: IconButton(
        icon: Icon(
          Icons.send,
          size: AppDim.iconMedium,
          color: AppColors.primary,
        ),
        onPressed: () {
          if(provider.chatComposerController.text.isNotEmpty){
            provider.sendMessage();
          }
        },
      ),
    );
  }
}
