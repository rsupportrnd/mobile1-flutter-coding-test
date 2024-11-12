import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDTO {
  final String userId;
  final String name;
  final String email;
  final String profilePicture;
  final String status;
  final String role;

  UserDTO({
    required this.userId,
    required this.name,
    required this.email,
    required this.profilePicture,
    required this.status,
    required this.role,
  });

  /// JSON 데이터를 UserDTO로 변환
  factory UserDTO.fromJson(Map<String, dynamic> json) => _$UserDTOFromJson(json);

  /// UserDTO를 JSON 데이터로 변환
  Map<String, dynamic> toJson() => _$UserDTOToJson(this);

  /// JSON 데이터 리스트를 UserDTO 리스트로 변환
  static List<UserDTO> jsonList(List<dynamic> json) {
    return json
        .map((item) => UserDTO.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}