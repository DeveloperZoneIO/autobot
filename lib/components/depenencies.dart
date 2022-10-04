import 'package:autobot/shared/paths/paths.dart';
import 'package:get_it/get_it.dart';

final inject = GetIt.instance;
final getIt = inject;

class Dependencies {
  static void init() {
    getIt.registerSingleton<Paths>(AutobotPaths());
  }
}
