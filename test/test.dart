import 'package:test/test.dart';

final spaceAge = SpaceAge();

void main() {
  group('SpaceAge', ageOnPlanetTests);
}

class SpaceAge{
  final num yearSec = 31557600; //365.25 지구일

  num age({String planet = '', seconds}){
    num planetCycle = getPlanetCycle(planet); //행성별 공전주기 가져오기
    num value = seconds / yearSec / planetCycle;
    value = double.parse(value.toStringAsFixed(2));

    //print('$seconds초 / $planet / $value 세');
    return value;
  }

  //각 행성별 공전주기를 가져옵니다. 지구 기준(1.0)
  num getPlanetCycle(String planetName){
    num cycle;
    switch( planetName ){
      case 'Mercury': cycle = 0.2408467; break;
      case 'Venus': cycle = 0.61519726; break;
      case 'earth': cycle = 1.0; break;
      case 'Mars': cycle = 1.8808158; break;
      case 'Jupiter': cycle = 11.862615; break;
      case 'Saturn': cycle = 29.447498; break;
      case 'Uranus': cycle = 84.016846; break;
      case 'Neptune': cycle = 164.79132; break;
      default: cycle = 1.0; break;
    }
    return cycle;
  }
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
