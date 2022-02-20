import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:autobot/commands/init/init.dart';
import 'package:autobot/commands/run/run.dart';
import 'package:autobot/commands/version/version.dart';
import 'package:autobot/common/dcli_utils.dart';
import 'package:autobot/common/exceptions.dart';
import 'package:autobot/components/autobot_config.dart';
import 'package:autobot/components/autobot_constants.dart';
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
  CommandRunner(Pubspec.name, Pubspec.description)
    ..addCommand(RunCommand(config))
    ..addCommand(InitCommand())
    ..addCommand(VersionCommand())
    ..run(args);
}

AutobotConfig? _getAutobotConfig() {
  final workingPath = '$pwd/${AutobotConstants.configFileName}';
  final homePath = '$homeDirectory/${AutobotConstants.configFileName}';
  return AutobotConfig.fromFileOrNull(workingPath) ?? AutobotConfig.fromFileOrNull(homePath);
}


// final specificFilePath = '$pwd/$kConfigFileName.yaml';
//     final globalFilePath = '$homeDir/.$kConfigFileName.yaml';
//     final readProgress = tryRead(specificFilePath) ?? tryRead(globalFilePath);
//     final templateContent =
//         readProgress.unpackOrThrow(MissingConfigFile()).toParagraph();
//     return loadYaml(templateContent)['config'];