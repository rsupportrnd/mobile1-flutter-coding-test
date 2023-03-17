class SpaceAge {
  double age({required String planet, required int seconds}) {
    // Initial is "Earth" year seconds
    int earthYear = 31557600;

    // Calculate other planet year factor
    late double planetYear;
    switch (planet) {
      case 'Mercury':
        planetYear = earthYear * 0.2408467;
        break;
      case 'Venus':
        planetYear = earthYear * 0.61519726;
        break;
      case 'Earth':
        planetYear = earthYear * 1.0;
        break;
      case 'Mars':
        planetYear = earthYear * 1.8808158;
        break;
      case 'Jupiter':
        planetYear = earthYear * 11.862615;
        break;
      case 'Saturn':
        planetYear = earthYear * 29.447498;
        break;
      case 'Uranus':
        planetYear = earthYear * 84.016846;
        break;
      case 'Neptune':
        planetYear = earthYear * 164.79132;
        break;
      default:
    }

    late double years = double.parse((seconds / planetYear).toStringAsFixed(2));
    return years;
  }
}
