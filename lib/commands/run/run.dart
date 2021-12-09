import 'package:args/command_runner.dart';
import 'package:dcli/dcli.dart';

part 'config.dart';

class RunCommand extends Command {
  RunCommand() {
    config = RunConfig(
      templateDirectory: '$pwd/templates/',
    );
  }

  late final RunConfig config;

  @override
  String get description => 'Runs a yaml template file.';
  @override
  String get name => 'run';

  @override
  void run() {}
}
