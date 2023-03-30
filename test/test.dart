import 'package:test/test.dart';

final spaceAge = SpaceAge();

class SpaceAge {
  age({required String planet, required num seconds}) {
    num expectAge = 0.0;
    num conversionIndicator = 0.0;

    double benchmarkAge(num seconds) {
      return seconds / (60.0 * 60.0 * 24.0 * 365.25);
    }

    switch(planet) {
      case 'Earth':
        conversionIndicator = 1.0;
        break;
      case 'Mars' :
        conversionIndicator = 1.8808158;
        break;
      case 'Mercury' :
        conversionIndicator = 0.2408467;
        break;
      case 'Venus' :
        conversionIndicator = 0.61519726;
        break;
      case 'Jupiter' :
        conversionIndicator = 11.862615;
        break;
      case 'Saturn' :
        conversionIndicator = 29.447498;
        break;
      case 'Uranus' :
        conversionIndicator = 84.016846;
        break;
      case 'Neptune' :
        conversionIndicator = 164.79132;
        break;
    }

    expectAge = double.parse((benchmarkAge(seconds) / conversionIndicator).toStringAsFixed(2));

    return expectAge;
  }
}

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
