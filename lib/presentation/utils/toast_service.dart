import 'package:fluttertoast/fluttertoast.dart';

abstract class ToastService {
  void show(String message);
}

class ToastServiceImpl implements ToastService {
  @override
  void show(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }
}
