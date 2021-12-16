import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:autobot/commands/init/init.dart';
import 'package:autobot/commands/run/run.dart';
import 'package:autobot/commands/version/version.dart';
import 'package:autobot/common/exceptions.dart';
import 'package:autobot/pubspec.dart';
import 'package:dcli/dcli.dart';

const kConfigFileName = 'autobot_config';

void main(List<String> args) async {
  runZonedGuarded(() => _runAutobot(args), (e, trace) {
    if (e is PrintableException) {
      e.tellUser();
    } else {
      print(red(e.toString()));
    }
  });
}

void _runAutobot(List<String> args) async {
  CommandRunner(Pubspec.name, Pubspec.description)
    ..addCommand(RunCommand())
    ..addCommand(InitCommand())
    ..addCommand(VersionCommand())
    ..run(args);
}
