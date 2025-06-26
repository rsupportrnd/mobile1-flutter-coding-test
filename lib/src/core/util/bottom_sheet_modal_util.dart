import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/src/domain/entity/user_list_response_entity.dart';

class BottomSheetUtil {
  static void showUserDetailSheet({
    required BuildContext context,
    required UserEntity user,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (context) => UserDetailBottomSheet(user: user),
    );
  }
}
