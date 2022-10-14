import 'package:autobot/commands/init/init.dart';
import 'package:autobot/commands/version/version.dart';
import 'package:autobot/essentials/command_line_app/command_line_app.dart';
import 'package:get_it/get_it.dart';

import '../shared/base_paths/base_paths.dart';

final getIt = GetIt.instance;
final provide = GetIt.instance;

R provideAs<T, R>() => provide<T>() as R;

class Dependencies {
  static void init() {
    _registerSingletons();
    _registerFactories();
  }

  static void _registerSingletons() {
    ifNotRegistered<BasePaths>()?.registerSingleton<BasePaths>(AutobotBasePaths());
    ifNotRegistered<CLAController>()?.registerSingleton<CLAController>(CLAControllerImpl());
  }

  static void _registerFactories() {
    getIt.registerFactory(() => InitCommand(
          paths: provide(),
          appController: provide(),
        ));

    getIt.registerFactory(() => VersionCommand(
          appController: provide(),
        ));
  }

  static GetIt initWithMocks({required void Function(GetIt) mockRegistrant}) {
    mockRegistrant(getIt);
    init();
    return getIt;
  }

  static GetIt? ifNotRegistered<T extends Object>() {
    return getIt.isRegistered<T>() ? null : getIt;
  }

  static void reset() => getIt.reset();
}
