import '../../../../core/error/result.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

/// Single-responsibility use case for fetching the active users list.
class GetUsersUseCase {
  const GetUsersUseCase(this._repository);

  final UserRepository _repository;

  Future<Result<List<UserEntity>>> call() => _repository.getUsers();
}
