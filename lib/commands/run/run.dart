import 'package:args/command_runner.dart';
import 'package:dcli/dcli.dart';

part 'config.dart';

class RunCommand extends Command {
  static const kOptionTemplate = 'template';
  static const kOptionTemplateAbbr = 't';

  RunCommand() {
    _readConfig();
    _addOptions();
  }

  late final RunConfig config;

  @override
  String get description => 'Runs a yaml template file.';
  @override
  String get name => 'run';

  @override
  void run() {}

  void _readConfig() {
    config = RunConfig(
      templateDirectory: '$pwd/templates/',
    );
  }

  void _addOptions() {
    argParser.addOption(kOptionTemplate, abbr: kOptionTemplateAbbr, mandatory: true);
  }
}
