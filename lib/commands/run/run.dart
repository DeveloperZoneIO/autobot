import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:autobot/autobot.dart';
import 'package:autobot/commands/run/models/template.dart';
import 'package:autobot/commands/run/models/template.mapper.g.dart';
import 'package:autobot/common/dcli_utils.dart';
import 'package:autobot/common/exceptions.dart';
import 'package:autobot/common/collection_util.dart';
import 'package:autobot/common/null_utils.dart';
import 'package:autobot/common/yaml_utils.dart';
import 'package:autobot/config_reader.dart';
import 'package:cli_script/cli_script.dart' hide read;
import 'package:dart_mappable/dart_mappable.dart';
import 'package:dcli/dcli.dart' hide run;
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
part 'script_service.dart';
part 'base_scrip_runner.dart';
part 'js_runner.dart';
part 'shell_runner.dart';

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

  @override
  void run() async {
    config = readConfig();
    final template = readTemplate();
    final promptVariables = readInputs(template);
    final envFileInputs = readEnvironmentFile();
    final environmentInputs = readEnvironment();
    final variables = <String, dynamic>{}
      ..addAll(environmentInputs)
      ..addAll(envFileInputs)
      ..addAll(promptVariables);
    final processedVariables = await runScripts(template.scripts, variables: variables);
    print(grey(jsonEncode(processedVariables)));
    final tasks = buildOuputTasks(template.outputs, variables: processedVariables);
    writeOutputs(tasks);
  }
}

extension FunctionalRunCommand on RunCommand {
  TemplateDef readTemplate() => RunTemplateReader(this).readTemplate();
  Map<String, String> readInputs(TemplateDef template) =>
      InputReader(this).collectInputsFromArgs().askForInputvalues(template);
  Map<String, String> readEnvironment() => EnvironmentReader(this).readEnvironment();
  Map<String, dynamic> readEnvironmentFile() => EnvironmentReader(this).readEnvironmentFiles();
  RunConfig readConfig() => RunConfigReader(this).readConfig();
  List<OutputTask> buildOuputTasks(List<OutputDef> outputs, {required Map<String, dynamic> variables}) =>
      OutputTaskBuilder(this) //
          .collectVariables(variables)
          .buildTasks(outputs);

  void writeOutputs(List<OutputTask> tasks) => OutputWriter(this).writeOutputs(tasks);
  Future<Map<String, dynamic>> runScripts(List<ScriptDef> scriptDefs, {required Map<String, dynamic> variables}) =>
      ScriptService(this).runScripts(scriptDefs, variables);
}
