// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:args/command_runner.dart';

import 'package:autobot/schema/arguments.dart';

import '../commands/run/run.dart';

class ArgumentShortcutResolver {
  final Arguments arguments;
  final CommandRunner commandRunner;

  ArgumentShortcutResolver({
    required this.arguments,
    required this.commandRunner,
  });

  Iterable<String> resolveShortcuts() {
    if (arguments.isEmpty) {
      return const [];
    }

    if (_isRequestedCommandValid(arguments)) {
      return arguments;
    }

    final args = _addMissingRunCommandArguments(arguments);
    return args;
  }

  bool _isRequestedCommandValid(Arguments arguments) {
    final requestedCommandName = arguments.first;
    final availableCommandNames = commandRunner.commands.keys.toList();
    return availableCommandNames.contains(requestedCommandName);
  }

  Arguments _addMissingRunCommandArguments(Arguments incompleteArguments) {
    final runCommand = commandRunner.commands.values //
        .whereType<RunCommand>()
        .first;

    final runTaskArguments = [
      runCommand.name,
      '--' + runCommand.args.kOptionTask
    ];

    return Arguments(runTaskArguments + arguments);
  }
}
