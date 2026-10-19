import 'package:app_sido/src/core/error/result.dart';
import 'package:app_sido/src/features/users/domain/entities/user_entity.dart';
import 'package:app_sido/src/features/users/domain/repositories/user_repository.dart';
import 'package:app_sido/src/features/users/domain/usecases/get_users_usecase.dart';
import 'package:app_sido/src/features/users/presentation/controllers/users_controller.dart';
import 'package:app_sido/src/features/users/presentation/screens/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeUserRepository implements UserRepository {
  @override
  Future<Result<List<UserEntity>>> getUsers() async {
    return const Success([
      UserEntity(
        id: 1,
        username: 'juan_sido',
        email: 'juan@sido.com',
        firstName: 'Juan',
        lastName: 'Manzano',
      ),
    ]);
  }
}

void main() {
  testWidgets('UsersScreen muestra la lista de usuarios desde el caso de uso', (
    WidgetTester tester,
  ) async {
    final controller = UsersController(GetUsersUseCase(_FakeUserRepository()));

    await tester.pumpWidget(
      MaterialApp(
        home: UsersScreen(controller: controller),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('SIDO · Usuarios'), findsOneWidget);
    expect(find.text('Juan Manzano'), findsOneWidget);
    expect(find.text('juan@sido.com'), findsOneWidget);
  });
}
