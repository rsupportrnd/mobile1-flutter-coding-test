import 'package:test/test.dart';

final spaceAge = SpaceAge();

void main() {
  group('SpaceAge', ageOnPlanetTests);
}

void ageOnPlanetTests() {
  test('age on Earth', () {
    expect(spaceAge.age(planet: 'Earth', seconds: 1000000000), equals(31.69));
  }, skip: false);

  test('age on Mars', () {
    expect(spaceAge.age(planet: 'Mars', seconds: 1000000000), equals(16.85));
  }, skip: false);

  test('age on Mercury', () {
    expect(spaceAge.age(planet: 'Mercury', seconds: 2123231), equals(0.28));
  }, skip: false);

  test('age on Venus', () {
    expect(spaceAge.age(planet: 'Venus', seconds: 192837465), equals(9.93));
  }, skip: false);

  test('age on Mars', () {
    expect(spaceAge.age(planet: 'Mars', seconds: 321092394), equals(5.41));
  }, skip: false);

  test('age on Jupiter', () {
    expect(spaceAge.age(planet: 'Jupiter', seconds: 781273864), equals(2.09));
  }, skip: false);

  test('age on Saturn', () {
    expect(spaceAge.age(planet: 'Saturn', seconds: 3209128347), equals(3.45));
  }, skip: false);

  test('age on Uranus', () {
    expect(spaceAge.age(planet: 'Uranus', seconds: 127387982374), equals(48.05));
  }, skip: false);

  test('age on Neptune', () {
    expect(spaceAge.age(planet: 'Neptune', seconds: 727637162), equals(0.14));
  }, skip: false);
}

enum Planet { Earth, Mars, Mercury, Venus, Jupiter, Saturn, Uranus, Neptune }

class SpaceAge {
  static const _earthRevolSeconds = 31557600;

  double age({planet = '', seconds = 0}) {
    double age =
        seconds / (getRevolPeriod(Planet.values.byName(planet)) * _earthRevolSeconds);
    return double.parse(age.toStringAsFixed(2));
  }

  double getRevolPeriod(Planet planet) {
    switch (planet) {
      case Planet.Earth:
        return 1;
      case Planet.Mars:
        return 1.8808158;
      case Planet.Mercury:
        return 0.2408467;
      case Planet.Venus:
        return 0.61519726;
      case Planet.Jupiter:
        return 11.862615;
      case Planet.Saturn:
        return 29.447498;
      case Planet.Uranus:
        return 84.016846;
      case Planet.Neptune:
        return 164.79132;
      default:
        return 0;
    }
  }
}
