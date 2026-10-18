import 'package:flutter/material.dart';
import '../../features/users/presentation/screens/users_screen.dart';

/// Centralized route names and navigation generator.
/// Ready to migrate 1:1 to `GoRouter` when added to `pubspec.yaml`.
abstract final class AppRouter {
  static const String home = '/';
  static const String users = '/users';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return switch (settings.name) {
      home || users => MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => const UsersScreen(),
      ),
      _ => MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => Scaffold(
          body: Center(
            child: Text('Ruta no encontrada: ${settings.name}'),
          ),
        ),
      ),
    };
  }
}
