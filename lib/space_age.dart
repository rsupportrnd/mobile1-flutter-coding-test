import 'package:rs_flutter_test/planets.dart';

class SpaceAge {
  static const int _secondsInEarthYear = 31557600;

  double age({required String planet, required int seconds}) {
    assert(seconds >= 0, 'Seconds must be a positive integer');
    final planetRevolutionSeconds = Planets.from(planet).revolutionPeriod;
    final result = seconds / _secondsInEarthYear / planetRevolutionSeconds;
    return double.parse(result.toStringAsFixed(2));
  }
}