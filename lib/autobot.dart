import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:autobot/common/exceptions.dart';
import 'package:autobot/di/get_it_provider.dart';
import 'package:autobot/di/init_dependencies.dart';
import 'package:autobot/schema/arguments.dart';
import 'package:autobot/services/argument_shortcut_resolver.dart';
import 'package:autobot/tell.dart';
import 'package:dcli/dcli.dart';

void main(List<String> args) async {
  final arguments = Arguments.from(args);
  registerDependencies(arguments: arguments);
  registerCommandsAndRunner();
  runZonedGuarded(_runAutobot, _onError);
}

void _runAutobot() {
  final shortcutResolver = provide<ArgumentShortcutResolver>();
  final resolvedArguments = shortcutResolver.resolveShortcuts();
  provide<CommandRunner>().run(resolvedArguments);
}

void _onError(Object error, StackTrace trace) {
  if (error is PrintableException) {
    error.tellUser();
  } else {
    tell(red(error.toString()));
  }
}
