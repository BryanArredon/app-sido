/// Pure domain entity representing a User in SIDO.
/// Free of JSON serialization or framework dependencies.
class UserEntity {
  const UserEntity({
    required this.id,
    required this.username,
    required this.email,
    this.firstName = '',
    this.lastName = '',
  });

  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;

  String get fullName {
    final full = '$firstName $lastName'.trim();
    return full.isEmpty ? username : full;
  }
}
