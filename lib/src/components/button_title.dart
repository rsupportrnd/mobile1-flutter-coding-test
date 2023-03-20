import 'package:flutter/material.dart';

class ButtonTitle extends StatelessWidget {
  String buttonTitle;
  bool? isFirstButton = false;
  String? subTitle;
  ButtonTitle(
      {super.key,
      required this.buttonTitle,
      this.isFirstButton,
      this.subTitle});

  Widget firstButton() {
    return Column(
      children: [
        Text(buttonTitle),
        SizedBox(height: 10.0),
      ],
    );
  }

  Widget defaultButton() {
    return Column(
      children: [
        SizedBox(height: 20.0),
        firstButton(),
      ],
    );
  }

  Widget subTitleButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.0),
        Text(buttonTitle),
        Text(
          subTitle!,
          style: TextStyle(
            fontSize: 12.0,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 10.0),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isFirstButton == true) {
      return firstButton();
    } else if (subTitle != null) {
      return subTitleButton();
    } else {
      return defaultButton();
    }
  }
}
