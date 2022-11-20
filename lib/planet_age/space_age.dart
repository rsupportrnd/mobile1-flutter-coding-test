import 'package:rs_flutter_test/planet_age/planet_age_cal.dart';

class SpaceAge {
  double age({required String planet, required int seconds}) {
    double age = PlanetAgeCal.defaultNum;

    age = PlanetAgeCal().age(planet, seconds);

    return age > 0 ? ((age * 100).round() / 100.0) : PlanetAgeCal.defaultNum;
  }
}
