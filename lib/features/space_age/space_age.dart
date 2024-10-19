import 'planets.dart';

class SpaceAge {
  static const int _inEarthYearSeconds = 31557600;

  double age({required String planet, required int seconds}) {
    assert(seconds >= 0, 'Seconds must be a positive integer');
    final result = seconds / _inEarthYearSeconds / Planets.from(planet).revolutionPeriod;
    return double.parse(result.toStringAsFixed(2));
  }
}