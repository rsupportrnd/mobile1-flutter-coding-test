import 'package:rs_flutter_test/planets.dart';

class SpaceAge {
  static int secondsInEarthYear = 31557600;

  double age({required String planet, required int seconds}) {
    final planetRevolutionSeconds = Planets.from(planet).revolutionPeriod;
    final result = seconds / secondsInEarthYear / planetRevolutionSeconds;
    return double.parse(result.toStringAsFixed(2));
  }
}