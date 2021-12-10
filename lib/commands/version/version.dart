import 'package:args/command_runner.dart';
import 'package:autobot/package_info.dart';
import 'package:dcli/dcli.dart';

class VersionCommand extends Command {
  @override
  String get description => 'Prints the version of auotbot.';

  @override
  String get name => 'version';

  @override
  void run() async {
    await PackageInfo.load();
    final message = '${PackageInfo.name} ${PackageInfo.version}';
    print(orange(message));
  }
}
