import 'package:args/command_runner.dart';
import 'package:autobot/pubspec.dart';
import 'package:autobot/tell.dart';
import 'package:dcli/dcli.dart';

/// Defines the version command of autobot.
/// `autobot version` print the version of the installed autobot.
class VersionCommand extends Command {
  @override
  String get description => 'Prints the version of auotbot.';

  @override
  String get name => 'version';

  @override
  void run() async {
    final message = '${Pubspec.name} ${Pubspec.version}';
    tell(orange(message));
  }
}
