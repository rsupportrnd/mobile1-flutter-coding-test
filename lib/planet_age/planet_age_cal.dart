import 'package:rs_flutter_test/planet_age/planet.dart';

class PlanetAgeCal {
  static final PlanetAgeCal _planetCal = PlanetAgeCal._internal();
  static const double _earthSec = 31557600.0;
  static const double defaultNum = 0.0;

  factory PlanetAgeCal() {
    return _planetCal;
  }

  PlanetAgeCal._internal();

  /// 수성: 공전주기 0.2408467 지구년
  /// 금성: 공전주기 0.61519726 지구년
  /// 지구: 공전주기 1.0 지구년, 365.25 지구일 또는 31557600초
  /// 화성: 공전주기 1.8808158 지구년
  /// 목성: 공전주기 11.862615 지구년
  /// 토성: 공전주기 29.447498 지구년
  /// 천왕성: 공전주기 84.016846 지구년
  /// 해왕성: 공전주기 164.79132 지구년
  ///
  static Planet get _earth => Planet("Earth", _earthSec);

  static Planet get _mars => Planet("Mars", _earthSec * 1.8808158);

  static Planet get _mercury => Planet("Mercury", _earthSec * 0.2408467);

  static Planet get _venus => Planet("Venus", _earthSec * 0.61519726);

  static Planet get _jupiter => Planet("Jupiter", _earthSec * 11.862615);

  static Planet get _saturn => Planet("Saturn", _earthSec * 29.447498);

  static Planet get _uranus => Planet("Uranus", _earthSec * 84.016846);

  static Planet get _neptune => Planet("Neptune", _earthSec * 164.79132);

  final List<Planet> _list = <Planet>[
    _earth,
    _mars,
    _mercury,
    _venus,
    _jupiter,
    _saturn,
    _uranus,
    _neptune
  ];

  double age(String planet, int seconds) {
    double age = defaultNum;

    Planet data =
        _list.firstWhere((element) => element.name == planet, orElse: () {
      return Planet("", defaultNum);
    });
    age = data.age;
    return age > 0 ? seconds / age : defaultNum;
  }
}
