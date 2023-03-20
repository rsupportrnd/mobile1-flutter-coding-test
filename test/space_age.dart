enum PlanetType {
  unknown('Unknown', 0.0),
  mercury('Mercury', 0.2408467),
  venus('Venus', 0.61519726),
  earth('Earth', 1),
  mars('Mars', 1.8808158),
  jupiter('Jupiter', 11.862615),
  saturn('Saturn', 29.447498),
  uranus('Uranus', 84.016846),
  neptune('Neptune', 164.79132);

  final String name;
  final double orbitalPeriod;
  const PlanetType(this.name, this.orbitalPeriod);

  factory PlanetType.createFromName(String name) {
    return PlanetType.values.firstWhere(
      (element) => element.name == name,
      orElse: () => PlanetType.unknown,
    );
  }
}

class SpaceAge {
  static const double earthSeconds = 31557600.0;

  double age({
    required String planet,
    required int seconds,
  }) {
    final planetType = PlanetType.createFromName(planet);
    if (planetType == PlanetType.unknown) {
      return 0;
    }

    final age = (seconds / (earthSeconds * planetType.orbitalPeriod));
    return double.tryParse(age.toStringAsFixed(2)) ?? -1;
  }
}
