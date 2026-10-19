import '../../domain/entities/user_entity.dart';

/// Data Transfer Object (DTO) mapping `api-sido` JSON payloads to [UserEntity].
class UserModel {
  const UserModel({
    required this.id,
    required this.username,
    required this.email,
    this.firstName = '',
    this.lastName = '',
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      username: json['username'] as String? ?? '',
      email: json['email'] as String? ?? '',
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
    );
  }

  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'email': email,
    'first_name': firstName,
    'last_name': lastName,
  };

  UserEntity toEntity() => UserEntity(
    id: id,
    username: username,
    email: email,
    firstName: firstName,
    lastName: lastName,
  );
}
