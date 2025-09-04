import 'package:flutter/widgets.dart';

import 'message_element.dart';

class TextMessageElement extends MessageElement {
  final String text;
  TextMessageElement({required this.text});
  @override
  Widget toWidget(BuildContext context) {
    return Text(text);
  }

  @override
  MessageElement copyWith() {
    return TextMessageElement(text: text);
  }
}
