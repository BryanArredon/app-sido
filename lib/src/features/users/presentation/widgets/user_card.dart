import 'package:flutter/material.dart';
import '../../domain/entities/user_entity.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.user});

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            user.username.isNotEmpty ? user.username[0].toUpperCase() : '?',
          ),
        ),
        title: Text(user.fullName),
        subtitle: Text(user.email),
      ),
    );
  }
}
