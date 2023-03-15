import 'package:args/command_runner.dart';
import 'package:autobot/commands/init/init.dart';
import 'package:autobot/commands/run/run.dart';
import 'package:autobot/commands/version/version.dart';
import 'package:autobot/di/get_it_provider.dart';
import 'package:autobot/pubspec.dart';
import 'package:autobot/schema/arguments.dart';
import 'package:autobot/services/argument_shortcut_resolver.dart';
import 'package:autobot/services/autobot_config_finder.dart';

void registerDependencies({required Arguments arguments}) {
  provider.registerSingleton<Arguments>(arguments);
  provider.registerSingleton<AutobotConfigReader>(AutobotConfigReader());

  provider.registerFactory<ArgumentShortcutResolver>(
    () => ArgumentShortcutResolver(
      arguments: provide(),
      commandRunner: provide(),
    ),
  );
}

void registerCommandsAndRunner() {
  provider.registerSingleton(InitCommand());
  provider.registerSingleton(VersionCommand());
  provider.registerSingleton(RunCommand(configReader: provide()));

  provider.registerSingleton(
    CommandRunner(Pubspec.name, Pubspec.description)
      ..addCommand(provide<RunCommand>())
      ..addCommand(provide<InitCommand>())
      ..addCommand(provide<VersionCommand>()),
  );
}
