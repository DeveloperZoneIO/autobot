import 'package:args/command_runner.dart';
import 'package:autobot/pubspec.dart';
import 'package:dcli/dcli.dart';

class VersionCommand extends Command {
  @override
  String get description => 'Prints the version of auotbot.';

  @override
  String get name => 'version';

  @override
  void run() async {
    final message = '${Pubspec.name} ${Pubspec.version}';
    print(orange(message));
  }
}
