import 'package:flutter/material.dart';
import 'package:mobile1_flutter_coding_test/src/core/common/exception/custom_exception.dart';
import 'package:mobile1_flutter_coding_test/src/core/constant/string_constant/common_string_constant.dart';
import 'package:mobile1_flutter_coding_test/src/core/util/throttle.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    required this.onPressed,
    required this.appException,
  });

  final AppException appException;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final Throttle throttle = Throttle(delay: const Duration(seconds: 1));

    return Scaffold(
        body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            appException.message,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              throttle.run(() {
                onPressed(); // 실제 동작
              });
            },
            child: const Text(CommonStringConstant.newTry),
          ),
        ],
      ),
    ));
  }
}
