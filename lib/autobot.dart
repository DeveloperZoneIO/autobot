import 'package:args/command_runner.dart';
import 'package:autobot/commands/init/init.dart';
import 'package:autobot/commands/run/run.dart';
import 'package:autobot/config_reader.dart';
import 'package:autobot/package_info.dart';
import 'package:dcli/dcli.dart';

const kConfigFileName = 'autobot_config';

void main(List<String> args) async {
  await PackageInfo.load();

  try {
    final configYaml = ConfigReader.readConfig();
    final runner = CommandRunner(PackageInfo.name, PackageInfo.description);
    runner.addCommand(RunCommand(configYaml: configYaml));
    runner.addCommand(InitCommand());
    runner.run(args);
  } catch (e) {
    print(red(e.toString()));
  }
}
