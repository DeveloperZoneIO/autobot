import 'package:get_it/get_it.dart';

import '../shared/base_paths/base_paths.dart';

final inject = GetIt.instance;
final getIt = inject;
final provide = inject;

class Dependencies {
  static void init() {
    getIt.registerSingleton<BasePaths>(AutobotBasePaths());
  }
}
