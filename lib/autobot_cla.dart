import 'package:args/command_runner.dart';
import 'package:autobot/arguments_resolver.dart';
import 'package:autobot/components/depenencies.dart';
import 'package:meta/meta.dart';

import 'package:autobot/essentials/command_line_app/command_line_app.dart';

import 'commands/init/init.dart';
import 'commands/run/run.dart';
import 'commands/version/version.dart';
import 'components/autobot_config.dart';
import 'components/files.dart';
import 'pubspec.dart';

class AutobotCLA extends CommanLineApp {
  AutobotCLA({required this.arguments});

  final List<String> arguments;

  @override
  @protected
  void runner(CLAController appController) {
    final config = _getAutobotConfig();
    final runner = CommandRunner(Pubspec.name, Pubspec.description);
    // runner.addCommand(RunCommand(config));
    runner.addCommand(InitCommand(
      appController,
      paths: inject(),
    ));
    // runner.addCommand(VersionCommand());

    final commandNames = runner.commands.keys.toList();
    final resolvedArgs = ArgumentsResolver().resolveShortcuts(arguments, commandNames);
    runner.run(resolvedArgs);
  }

  AutobotConfig? _getAutobotConfig() =>
      AutobotConfig.fromFile(Files.local.config) ?? //
      AutobotConfig.fromFile(Files.global.config);
}
