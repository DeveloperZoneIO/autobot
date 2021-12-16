import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:autobot/autobot.dart';
import 'package:autobot/commands/run/models/template.dart';
import 'package:autobot/commands/run/models/template.mapper.g.dart';
import 'package:autobot/common/dcli_utils.dart';
import 'package:autobot/common/exceptions.dart';
import 'package:autobot/common/map_util.dart';
import 'package:autobot/common/null_utils.dart';
import 'package:autobot/common/yaml_utils.dart';
import 'package:autobot/config_reader.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:dcli/dcli.dart';
import 'package:mustache_template/mustache.dart';
import 'package:yaml/yaml.dart';

part 'run_config_reader.dart';
part 'environment_reader.dart';
part 'input_reader.dart';
part 'output_writer.dart';
part 'template_reader.dart';
part 'utils/render_mixin.dart';
part 'utils/string_to_bool.dart';
part 'output_task_builder.dart';

part 'models/config.dart';
part 'models/input.dart';
part 'models/output_task.dart';

class RunCommand extends Command {
  final kOptionTemplate = 'template';
  final kOptionTemplateAbbr = 't';
  final kOptionInput = 'input';
  final kOptionInputAbbr = 'i';

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
    argParser.addMultiOption(kOptionInput, abbr: kOptionInputAbbr);
  }

  void _addInputOptions(List<InputDef> inputDefs) {
    final inputKeys = inputDefs.map((inputDef) => inputDef.key);
    inputKeys.forEach((key) => argParser.addOption(key));
  }

  @override
  void run() {
    config = readConfig();
    final template = readTemplate();
    _addInputOptions(template.inputs);
    final userInputs = readInputs(template);
    final envFileInputs = readEnvironmentFile();
    final environmentInputs = readEnvironment();
    final inputs = environmentInputs + envFileInputs + userInputs;
    final tasks = buildOuputTasks(template.outputs, inputs: inputs);
    writeOutputs(tasks);
  }
}

extension FunctionalRunCommand on RunCommand {
  TemplateDef readTemplate() => RunTemplateReader(this).readTemplate();
  List<Input> readInputs(TemplateDef template) => InputReader(this).collectInputsFromArgs().askForInputvalues(template);
  List<Input> readEnvironment() => EnvironmentReader(this).readEnvironment();
  List<Input> readEnvironmentFile() => EnvironmentReader(this).readEnvironmentFiles();
  RunConfig readConfig() => RunConfigReader(this).readConfig();
  List<OutputTask> buildOuputTasks(List<OutputDef> outputs, {required List<Input> inputs}) => OutputTaskBuilder(this) //
      .collectInputs(inputs)
      .buildTasks(outputs);

  void writeOutputs(List<OutputTask> tasks) => OutputWriter(this).writeOutputs(tasks);
}
