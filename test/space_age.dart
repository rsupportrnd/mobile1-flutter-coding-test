class SpaceAge {
  // 지구 1년 -> 31557600초
  static const int earthSecond = 31557600;
  // 지구공전주기 : key = 1.0 : value
  static const Map<String, double> orbitalPeriod = {
    'Mercury': 0.2408467,
    'Venus': 0.61519726,
    'Earth': 1.0,
    'Mars': 1.8808158,
    'Jupiter': 11.862615,
    'Saturn': 29.447498,
    'Uranus': 84.016846,
    'Neptune': 164.79132,
  };

  double age({required String planet, required double seconds}) {
    var result = 0.0;
    orbitalPeriod.forEach((key, value) {
      if (planet == key) {
        result = seconds / (earthSecond * value);
      }
    });
    return double.parse(result.toStringAsFixed(2));
  }
}
