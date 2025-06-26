import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/src/domain/entity/user_list_response_entity.dart';
import 'package:mobile1_flutter_coding_test/src/presentation/user_list/view/user_detail_info_view.dart';

class BottomSheetUtil {
  BottomSheetUtil._();
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
      builder: (context) => UserDetailInfoView(userEntity: user),
    );
  }
}
