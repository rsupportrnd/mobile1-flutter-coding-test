import 'dart:ffi';

import 'package:rs_flutter_test/domain/space/exception/unknown_planet_exception.dart';

class SpaceAge{
  final _singleYearSecondByEarth = 31557600;
  final Map<String,double> _planetRotationRatioByEarthMap = {
    "Mercury" : 0.2408467,
    "Venus" : 0.61519726,
    "Earth" : 1.0,
    "Mars" : 1.8808158,
    "Jupiter" : 11.862615,
    "Saturn": 29.447498,
    "Uranus" : 84.016846,
    "Neptune" : 164.79132
  };

  double age({required String planet, required int seconds}) {

    final ratio = _planetRotationRatioByEarthMap[planet];

    if(ratio == null) {
      throw UnknownPlanetException();
    }

    return  (((seconds/_singleYearSecondByEarth / ratio)*100).roundToDouble())/100;
  }

  ///    expect(spaceAge.age(planet: 'Earth', seconds: 1000000000), equals(31.69));
}

