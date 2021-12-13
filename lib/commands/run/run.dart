import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:autobot/autobot.dart';
import 'package:autobot/common/dcli_utils.dart';
import 'package:autobot/common/exceptions.dart';
import 'package:autobot/common/null_utils.dart';
import 'package:autobot/common/yaml_utils.dart';
import 'package:autobot/config_reader.dart';
import 'package:dcli/dcli.dart';
import 'package:mustache_template/mustache.dart';
import 'package:yaml/yaml.dart';

part 'run_config_reader.dart';
part 'environment_reader.dart';
part 'input_reader.dart';
part 'output_reader.dart';
part 'output_writer.dart';
part 'template_reader.dart';
part 'utils/render_mixin.dart';
part 'utils/string_to_bool.dart';

part 'models/config.dart';
part 'models/input.dart';
part 'models/template_input_definition.dart';
part 'models/template_output_definition.dart';
part 'models/write_task.dart';

class RunCommand extends Command {
  static const kOptionTemplate = 'template';
  static const kOptionTemplateAbbr = 't';

  RunCommand() {
    _addOptions();
  }

  late final RunConfig config;

  @override
  String get description => 'Runs a yaml template file.';
  @override
  String get name => 'run';

  void _addOptions() {
    argParser.addOption(kOptionTemplate, abbr: kOptionTemplateAbbr, mandatory: true);
  }

  @override
  void run() {
    config = readConfig();
    final template = readTemplate();
    final userInputs = readInputs(template);
    final envFileInputs = readEnvironmentFile();
    final environmentInputs = readEnvironment();
    final outputs = readOutputs(template);

    writeOutputs(
      outputs,
      inputs: environmentInputs + envFileInputs + userInputs,
    );
  }
}

extension FunctionalRunCommand on RunCommand {
  YamlMap readTemplate() => RunTemplateReader(this).readTemplate();

  List<Input> readInputs(YamlMap template) => InputReader(this) //
      .collectInputDefinitionsFrom(template)
      .askForInputvalues()
      .getUserInputs();

  List<TemplateOutputDefinition> readOutputs(YamlMap template) => OutputReader(this) //
      .collectOutputsFrom(template)
      .getOutputs();

  void writeOutputs(List<TemplateOutputDefinition> outputs, {required List<Input> inputs}) => OutputWriter(this) //
      .collectVariables(inputs)
      .createWriteTasks(outputs)
      .writeOutputs();

  List<Input> readEnvironment() => EnvironmentReader(this).readEnvironment();
  List<Input> readEnvironmentFile() => EnvironmentReader(this).readEnvironmentFiles();

  RunConfig readConfig() => RunConfigReader(this).readConfig();
}
