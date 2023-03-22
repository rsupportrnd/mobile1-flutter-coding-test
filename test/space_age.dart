import 'wrong_planet_name_exception.dart';

/// 행성 나이를 계산할 떄 사용하는 class.
class SpaceAge {
  double age({
    required String planet,
    required int seconds,
  }) {
    const int secondsOfDay = 60 * 60 * 24;
    late double daysOfYear;

    switch (planet) {
      case 'Mercury':
        daysOfYear = 87.9691;
        break;
      case 'Venus':
        daysOfYear = 224.7;
        break;
      case 'Earth':
        daysOfYear = 365.2422;
        break;
      case 'Mars':
        daysOfYear = 686.971;
        break;
      case 'Jupiter':
        daysOfYear = 4332.59;
        break;
      case 'Saturn':
        daysOfYear = 10759.22;
        break;
      case 'Uranus':
        daysOfYear = 30687;
        break;
      case 'Neptune':
        daysOfYear = 60182;
        break;
      default:
        throw WrongPlanetNameException(planet);
    }

    return double.parse(
        (seconds / (daysOfYear * secondsOfDay)).toStringAsFixed(2));
  }
}
