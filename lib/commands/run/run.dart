import 'package:args/command_runner.dart';
import 'package:dcli/dcli.dart';
import 'package:yaml/yaml.dart';

part 'config.dart';
part 'template_reader.dart';

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
  void run() {
    final template = readTemplate();
  }

  void _readConfig() {
    config = RunConfig(
      templateDirectory: '$pwd/templates/',
    );
  }

  void _addOptions() {
    argParser.addOption(kOptionTemplate, abbr: kOptionTemplateAbbr, mandatory: true);
  }
}

extension FunctionalRunCommand on RunCommand {
  YamlMap readTemplate() => RunTemplateReader(this).readTemplate();
}
