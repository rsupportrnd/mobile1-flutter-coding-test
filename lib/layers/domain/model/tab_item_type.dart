import 'package:flutter/material.dart';

import '../../../../common/common.dart';

enum TabItemType {
  user(Icons.account_circle_outlined, AppStrings.userLabel, 0),
  meeting(Icons.chat, AppStrings.meetingLabel, 1);

  const TabItemType(this.icon, this.label, this.itemIndex);

  final IconData icon;
  final String label;
  final int itemIndex;
}