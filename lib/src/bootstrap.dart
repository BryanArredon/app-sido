import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

/// Global application bootstrap for Web, Android, and iOS:
/// - Configures clean URL paths on Web (`/users` instead of `/#/users`)
/// - Initializes Flutter bindings and global error boundaries
Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    debugPrint('[FlutterError] ${details.exceptionAsString()}');
  };

  PlatformDispatcher.instance.onError = (error, stackTrace) {
    debugPrint('[UncaughtError] $error\n$stackTrace');
    return true;
  };

  runApp(await builder());
}
