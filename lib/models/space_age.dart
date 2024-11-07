import 'package:rs_flutter_test/models/enums/planet.dart';

class SpaceAge {
  static const secondsOfYear = 60 * 60 * 24 * 365.25;
  double? age({
    required String planet,
    required int seconds,
  }) {
    try {
      final earthYear = (seconds / secondsOfYear);
      final planetYear = Planet.fromName(planet).year;

      //소수점 2자리 고정 반올림
      return double.parse((earthYear / planetYear).toStringAsFixed(2));
    } catch (e) {
      return null;
    }
  }
}
