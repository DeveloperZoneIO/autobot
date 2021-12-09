import 'package:args/command_runner.dart';

class RunCommand extends Command {
  @override
  String get description => 'Runs a yaml template file.';
  @override
  String get name => 'run';

  @override
  void run() {}
}
