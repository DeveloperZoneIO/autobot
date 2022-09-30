import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:autobot/commands/init/init.dart';
import 'package:autobot/commands/run/run.dart';
import 'package:autobot/commands/version/version.dart';
import 'package:autobot/common/dcli_utils.dart';
import 'package:autobot/common/exceptions.dart';
import 'package:autobot/components/autobot_config.dart';
import 'package:autobot/components/autobot_constants.dart';
import 'package:autobot/components/file_manager.dart';
import 'package:autobot/pubspec.dart';
import 'package:autobot/tell.dart';
import 'package:dcli/dcli.dart';

void main(List<String> args) async {
  runZonedGuarded(() => _runAutobot(args), (e, trace) {
    if (e is PrintableException) {
      e.tellUser();
    } else {
      tell(red(e.toString()));
    }
  });
}

/// Initializes all commands and runs the requested command.
void _runAutobot(List<String> args) async {
  final config = _getAutobotConfig();
  final commandRunner = CommandRunner(Pubspec.name, Pubspec.description)
    ..addCommand(RunCommand(config))
    ..addCommand(InitCommand())
    ..addCommand(VersionCommand());

  final commandNames = commandRunner.commands.keys.toList();
  final resolvedArgs = _resolveArgumentShortcuts(args, commandNames);
  commandRunner.run(resolvedArgs);
}

AutobotConfig? _getAutobotConfig() =>
    AutobotConfig.fromPathOrNull(Files.localConfigPath) ??
    AutobotConfig.fromPathOrNull(Files.globalConfigPath);

List<String> _resolveArgumentShortcuts(List<String> args, List<String> commandNames) {
  final resolvedArgs = List<String>.from(args);
  if (resolvedArgs.isNotEmpty) {
    final commandFromArgs = resolvedArgs.first;
    final doesCommandExist = commandNames.any((name) => name == commandFromArgs);

    if (!doesCommandExist) {
      final name = RunCommand.kName;
      final taskOption = '--${RunCommandArgs.kOptionTask}';
      resolvedArgs.insertAll(0, [name, taskOption]);
    }
  }

  return resolvedArgs;
}
