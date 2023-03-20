class SwitchStatus {
  final String key;
  bool value;
  SwitchStatus({required this.key, required this.value});

  factory SwitchStatus.fromJson(Map<String, dynamic> json) {
    return SwitchStatus(
      key: json['key'] as String,
      value: json['value'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'value': value,
    };
  }
}
