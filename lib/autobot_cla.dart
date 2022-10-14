import 'package:args/command_runner.dart';
import 'package:autobot/arguments_resolver.dart';
import 'package:autobot/components/depenencies.dart';
import 'package:autobot/shared/base_paths/base_paths.dart';
import 'package:autobot/shared/file_and_dir_paths/config_folder_structure.dart';
import 'package:autobot/shared/when/when.dart';
import 'package:meta/meta.dart';

import 'package:autobot/essentials/command_line_app/command_line_app.dart';

import 'commands/init/init.dart';
import 'commands/version/version.dart';
import 'components/autobot_config.dart';
import 'pubspec.dart';

class AutobotCLA extends CommanLineApp {
  AutobotCLA({required this.arguments})
      : super(
          name: Pubspec.name,
          description: Pubspec.description,
          controller: provide(),
        );

  final List<String> arguments;
  final BasePaths basePaths = provide();

  @override
  @protected
  void onCreate(CommandRegistrator register) {
    register(provide<InitCommand>());
    register(provide<VersionCommand>());
    // final config = _getAutobotConfig(appController);
    // runner.addCommand(RunCommand(config));
  }

  @override
  @protected
  List<String> getArguments(List<Command> commands) {
    final commandNames = commands.map((it) => it.name).toList();
    final resolvedArgs = ArgumentsResolver().resolveShortcuts(arguments, commandNames);
    return resolvedArgs;
  }
}
