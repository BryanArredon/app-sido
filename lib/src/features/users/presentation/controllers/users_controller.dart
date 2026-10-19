import 'package:flutter/foundation.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_users_usecase.dart';

/// Sealed UI state for the Users feature.
sealed class UsersState {
  const UsersState();
}

final class UsersInitial extends UsersState {
  const UsersInitial();
}

final class UsersLoading extends UsersState {
  const UsersLoading();
}

final class UsersLoaded extends UsersState {
  const UsersLoaded(this.users);
  final List<UserEntity> users;
}

final class UsersError extends UsersState {
  const UsersError(this.message);
  final String message;
}

/// Presentation controller (compatible with ValueNotifier / Riverpod Notifier).
class UsersController extends ValueNotifier<UsersState> {
  UsersController(this._getUsersUseCase) : super(const UsersInitial());

  final GetUsersUseCase _getUsersUseCase;

  Future<void> loadUsers() async {
    value = const UsersLoading();
    final result = await _getUsersUseCase();
    value = result.fold(
      onFailure: (failure) => UsersError(failure.message),
      onSuccess: UsersLoaded.new,
    );
  }
}
