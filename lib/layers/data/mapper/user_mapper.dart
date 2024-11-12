
import '../../domain/model/model.dart';
import '../entity/entity.dart';

class UserMapper {
  /// Entity -> Model
  static User toDomain(UserDTO dto) {
    return User(
      id: dto.userId,
      name: dto.name,
      email: dto.email,
      profilePictureUrl: dto.profilePicture,
      status: _mapStatus(dto.status),
      role: _mapRole(dto.role),
    );
  }

  /// UserDTO 리스트를 User 리스트로 변환하는 메서드
  static List<User> toDomainList(List<UserDTO> dtoList) {
    return dtoList.map((dto) => toDomain(dto)).toList();
  }

  /// UserStatus Enum 으로 변환 메서드
  static UserStatus _mapStatus(String status) {
    switch (status) {
      case 'online':
        return UserStatus.online;
      case 'offline':
        return UserStatus.offline;
      case 'away':
        return UserStatus.away;
      case 'do_not_disturb':
        return UserStatus.doNotDisturb;
      default:
        throw Exception('Unknown status: $status');
    }
  }

  /// UserRole Enum 으로 변환 메서드
  static UserRole _mapRole(String role) {
    switch (role) {
      case 'admin':
        return UserRole.admin;
      case 'member':
        return UserRole.member;
      default:
        throw Exception('Unknown role: $role');
    }
  }
}