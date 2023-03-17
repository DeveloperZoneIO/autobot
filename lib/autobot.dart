import 'package:args/command_runner.dart';
import 'package:autobot/services/argument_shortcut_resolver.dart';

class Autobot {
  final ArgumentShortcutResolver argsShortcutResolver;
  final CommandRunner commandRunner;

  Autobot({
    required this.argsShortcutResolver,
    required this.commandRunner,
  });

  void run() {
    final resolvedArguments = argsShortcutResolver.resolveShortcuts();
    commandRunner.run(resolvedArguments);
  }
}
