import 'dart:math';

extension DoubleExtension on double {
  double roundToDecimalPlaces(int num) {
    final salt = pow(10, num);

    return  (this * salt).roundToDouble() / salt;
  }
}
