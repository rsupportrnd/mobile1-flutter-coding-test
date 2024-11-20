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
}
