class SensorRotation {
  final double x;
  final double y;

  SensorRotation({required this.x, required this.y});

  factory SensorRotation.fromJson(Map<String, dynamic> json) {
    return SensorRotation(x: json['x'], y: json['y']);
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
    };
  }
}
