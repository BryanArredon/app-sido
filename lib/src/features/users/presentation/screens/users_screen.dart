import 'package:flutter/material.dart';

import '../../../../core/network/api_client.dart';
import '../../../../shared/widgets/adaptive_scaffold.dart';
import '../../../../shared/widgets/app_error_view.dart';
import '../../../../shared/widgets/app_loading_indicator.dart';
import '../../data/datasources/user_remote_datasource.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/usecases/get_users_usecase.dart';
import '../controllers/users_controller.dart';
import '../widgets/user_card.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key, this.controller});

  final UsersController? controller;

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  late final UsersController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ??
        UsersController(
          GetUsersUseCase(
            UserRepositoryImpl(
              UserRemoteDataSourceImpl(ApiClient()),
            ),
          ),
        );
    _controller.loadUsers();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      title: 'SIDO · Usuarios',
      destinations: const [
        AdaptiveDestination(
          label: 'Usuarios',
          icon: Icons.people_outline_rounded,
          selectedIcon: Icons.people_rounded,
        ),
        AdaptiveDestination(
          label: 'Ajustes',
          icon: Icons.settings_outlined,
          selectedIcon: Icons.settings_rounded,
        ),
      ],
      actions: [
        IconButton(
          onPressed: _controller.loadUsers,
          icon: const Icon(Icons.refresh_rounded),
          tooltip: 'Actualizar',
        ),
      ],
      body: ValueListenableBuilder<UsersState>(
        valueListenable: _controller,
        builder: (context, state, _) {
          return switch (state) {
            UsersInitial() || UsersLoading() => const AppLoadingIndicator(
              message: 'Cargando usuarios...',
            ),
            UsersError(:final message) => AppErrorView(
              message: message,
              onRetry: _controller.loadUsers,
            ),
            UsersLoaded(:final users) when users.isEmpty => const Center(
              child: Text('No hay usuarios registrados.'),
            ),
            UsersLoaded(:final users) => ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) => UserCard(user: users[index]),
            ),
          };
        },
      ),
    );
  }
}
