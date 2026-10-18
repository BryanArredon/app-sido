import 'src/app.dart';
import 'src/bootstrap.dart';

Future<void> main() async {
  await bootstrap(() => const SidoApp());
}
