import 'package:args/command_runner.dart' as args;
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
  AutobotCLA({required this.arguments}) : super(Pubspec.name, Pubspec.description);

  final List<String> arguments;
  final BasePaths basePaths = provide();

  @override
  @protected
  void onCreate(CommandRegistrator register) {
    register(InitCommand(appController, paths: inject()));
    register(VersionCommand());
  }

  @override
  @protected
  List<String> getArguments(List<Command> commands) {
    // final config = _getAutobotConfig(appController);
    // runner.addCommand(RunCommand(config));

    final commandNames = commands //
        .map((command) => command.name)
        .toList();

    final resolvedArgs = ArgumentsResolver().resolveShortcuts(arguments, commandNames);
    return resolvedArgs;
  }

  // Move to run command
  AutobotConfig _getAutobotConfig(CLAController appController) {
    final l = _hasLocalAutobotDir;
    final g = _hasGlobalAutobotDir;
    final customPath = basePaths.customDir;

    final basePath = when(_hasLocalAutobotDir)
        .then(() => basePaths.localDir)
        .orWhen(_hasGlobalAutobotDir)
        .then(() => basePaths.globalDir)
        .orWhen(customPath != null && ConfigFolderStructure.at(customPath).exists)
        .then(() => basePaths.customDir!)
        .orNone();

    if (basePath.isNone()) {
      appController.terminate(Print('No ${ConfigFolderConstants.folderNames.main} found'));
    }

    final config = ConfigFolderStructure.at(basePath.get()).configContent;
    if (config == null) {
      appController.terminate(Print('Config file could not be parsed'));
    }

    return config;
  }

  bool get _hasLocalAutobotDir => ConfigFolderStructure.at(basePaths.localDir).exists;
  bool get _hasGlobalAutobotDir => ConfigFolderStructure.at(basePaths.globalDir).exists;
}
