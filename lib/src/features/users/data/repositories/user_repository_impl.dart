import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/result.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_datasource.dart';

/// Concrete implementation of [UserRepository] mapping infrastructure exceptions
/// into domain [Failure] objects wrapped in [Result].
class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl(this._remoteDataSource);

  final UserRemoteDataSource _remoteDataSource;

  @override
  Future<Result<List<UserEntity>>> getUsers() async {
    try {
      final models = await _remoteDataSource.getUsers();
      final entities = models.map((m) => m.toEntity()).toList();
      return Success(entities);
    } on NetworkException catch (e) {
      return Err(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Err(ServerFailure(e.message, statusCode: e.statusCode));
    } catch (e) {
      return Err(ServerFailure('Error inesperado: $e'));
    }
  }
}
