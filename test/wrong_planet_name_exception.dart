/// 잘못된 행성 이름을 입력했을 때 발생하는 Exception.
class WrongPlanetNameException implements Exception {
  final String planet;

  WrongPlanetNameException(this.planet);

  @override
  String toString() {
    return 'WrongPlanetNameException: $planet is a non-existent planet.';
  }
}
