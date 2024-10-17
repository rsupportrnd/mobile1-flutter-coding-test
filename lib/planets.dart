enum Planets {
  mercury(0.2408467),
  venus(0.61519726),
  earth(1.0),
  mars(1.8808158),
  jupiter(11.862615),
  saturn(29.447498),
  uranus(84.016846),
  neptune(164.79132);

  const Planets(this.revolutionPeriod);

  final double revolutionPeriod;

  factory Planets.from(String planet) {
    try {
      return Planets.values.firstWhere((e) => e.name == planet.toLowerCase());
    } catch (e) {
      throw ArgumentError('Invalid planet');
    }
  }
}