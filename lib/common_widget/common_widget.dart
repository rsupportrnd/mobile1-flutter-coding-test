import 'package:mobile1_flutter_coding_test/index.dart';

class CommonWidgets {
  static AppBar getAppBar(
    BuildContext context, {
    String titleString = '푸푸',
    VoidCallback? backButtonMethod,
    bool isLeadingIcon = true,
  }) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: isLeadingIcon,
      surfaceTintColor: Colors.white,
      //addition
      elevation: 0.0,
      leading: isLeadingIcon
          ? IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: backButtonMethod ?? () => GoRouter.of(context).pop(),
            )
          : null,
      title: Text(
        titleString,
      ),
    );
  }

  static void showUserDetailAlertDialog(
    BuildContext context, {
    required UserModel user,
  }) {
    showDialog(
        context: context,
        barrierColor: Colors.grey.withOpacity(0.8),
        barrierDismissible: false,
        builder: (_) {
          final userAttributes = user.toJson();
          return AlertDialog(
            titlePadding: const EdgeInsets.all(20.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    GoRouter.of(context).pop();
                  },
                  child: const SizedBox(
                    child: Icon(Icons.cancel),
                  ),
                )
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: userAttributes.entries.map((entry) {
                return Text('${entry.key}: ${entry.value}');
              }).toList(),
            ),
          );
        });
  }
}
