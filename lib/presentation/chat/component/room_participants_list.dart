import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile1_flutter_coding_test/presentation/user/component/user_card.dart';
import 'package:mobile1_flutter_coding_test/presentation/user/view_model/user_view_model.dart';

class RoomParticipantsList extends ConsumerWidget {
  const RoomParticipantsList({super.key, required this.participants});
  final List<String> participants;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userList = ref.read(userViewModelProvider).value?.users ?? [];
    final viewPadding = MediaQuery.of(context).padding;
    return Container(
      padding:
          EdgeInsets.only(bottom: viewPadding.bottom, top: viewPadding.top),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: participants.length,
              itemBuilder: (context, index) {
                return UserCard.summary(
                    user: userList.firstWhere(
                        (user) => user.userId == participants[index]));
              },
            ),
          ),
        ],
      ),
    );
  }
}
