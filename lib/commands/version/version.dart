import 'package:args/command_runner.dart';
import 'package:autobot/essentials/command_line_app/command_line_app.dart';
import 'package:autobot/pubspec.dart';
import 'package:autobot/tell.dart';
import 'package:dcli/dcli.dart';

/// Defines the version command of autobot.
/// `autobot version` print the version of the installed autobot.
class VersionCommand extends CLACommand {
  VersionCommand({required this.appController})
      : super(name: 'version', description: 'Prints the version of auotbot.');

  final CLAController appController;

  @override
  void run() {
    final printMessage = Print(cyan('${Pubspec.name} ${Pubspec.version}'));
    appController.execute(printMessage);
  }
}
