import '../../../../core/error/result.dart';
import '../entities/user_entity.dart';

/// Domain repository contract for User operations.
abstract interface class UserRepository {
  Future<Result<List<UserEntity>>> getUsers();
}
