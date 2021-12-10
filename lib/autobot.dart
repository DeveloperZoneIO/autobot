import 'package:args/command_runner.dart';
import 'package:autobot/commands/init/init.dart';
import 'package:autobot/commands/run/run.dart';
import 'package:autobot/commands/version/version.dart';
import 'package:autobot/package_info.dart';
import 'package:dcli/dcli.dart';

const kConfigFileName = 'autobot_config';

void main(List<String> args) async {
  await PackageInfo.load();

  try {
    final runner = CommandRunner(PackageInfo.name, PackageInfo.description);
    runner.addCommand(RunCommand());
    runner.addCommand(InitCommand());
    runner.addCommand(VersionCommand());
    runner.run(args);
  } catch (e) {
    print(red(e.toString()));
  }
}
