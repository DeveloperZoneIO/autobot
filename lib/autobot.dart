import 'package:args/command_runner.dart';
import 'package:autobot/commands/run/run.dart';
import 'package:autobot/package_info.dart';

void main(List<String> args) async {
  await PackageInfo.load();
  CommandRunner(PackageInfo.name, PackageInfo.description)
    ..addCommand(RunCommand())
    ..run(args);
}
