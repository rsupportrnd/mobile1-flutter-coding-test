

import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/common/common.dart';
import 'package:provider/provider.dart';

import '../chat_viewmodel.dart';

class TextComposer extends StatelessWidget {
  const TextComposer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: AppDim.xSmall),
      child: Row(
        children: [
          _buildTextField(context),
          _buildSendButton(),
        ],
      ),
    );
  }

  _buildTextField(BuildContext context) {
    return Expanded(
      child: Container(
        height: UIConstants.textFieldHeight50,
        margin: const EdgeInsets.only(left: AppDim.small),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: UIConstants.borderMediumRadius
          ),
          color: Colors.grey.shade200,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDim.medium),
              child: MediaQuery(
                data: Etc.getScaleFontSize(context, fontSize: 0.9),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 20,
                  textInputAction: TextInputAction.done,
                  controller: TextEditingController(),
                  onChanged: (value){},
                  decoration: const InputDecoration.collapsed(hintText: '메시지 보내기'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildSendButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDim.xSmall),
      child: Consumer<ChatViewModel>(
          builder: (context, provider, child) {
            return IconButton(
              icon: Icon(
                  Icons.send,
                  size: AppDim.iconMedium,
                  color: AppColors.primary,
              ),
              color: AppColors.primary,
              onPressed:() =>{},
            );
          }
      ),
    );
  }

}
