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
import 'package:autobot/components/read_yaml_as.dart';
import 'package:autobot/components/resources.dart';
import 'package:autobot/config_reader.dart';
import 'package:autobot/tell.dart';
import 'package:cli_script/cli_script.dart' hide read;
import 'package:dart_mappable/dart_mappable.dart';
import 'package:dcli/dcli.dart' hide run;
import 'package:mustache_template/mustache.dart';
import 'package:yaml/yaml.dart';

part 'run_config_reader.dart';
part 'environment_reader.dart';
part 'input_reader.dart';
part 'input_file_reader.dart';
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

/// Defines the run command of autobot.
/// `autobot run -t <task_name>` runs the task machting to <task_name>.
/// `autobot run -t <task_name> -i var1=a,var2=b` runs the task machting to <task_name> and inserts the given variables to autobot variables.
class RunCommand extends Command {
  final kOptionTemplate = 'template';
  final kOptionTemplateAbbr = 't';
  final kOptionInput = 'input';
  final kOptionInputAbbr = 'i';
  final kOptionInputFile = 'input-file';
  final kOptionInputFileAbbr = 'f';

  RunCommand() {
    _addOptions();
  }

  late final RunConfig config;

  @override
  String get description => 'Runs a yaml template file.';
  @override
  String get name => 'run';

  /// Adds all options to run command.
  void _addOptions() {
    argParser.addOption(kOptionTemplate, abbr: kOptionTemplateAbbr, mandatory: true);
    argParser.addMultiOption(kOptionInput, abbr: kOptionInputAbbr);
    argParser.addMultiOption(kOptionInputFile, abbr: kOptionInputFileAbbr);
  }

  @override
  void run() async {
    config = readConfig();
    final template = readYamlAs<TemplateDef>(templateFilePath);
    final promptVariables = readInputs(template);
    final inputFileVariables = readInputFiles();
    final envFileVariables = readEnvironmentFile();
    final environmentVariables = readEnvironment();
    final variables = <String, dynamic>{}
      ..addAll(environmentVariables)
      ..addAll(envFileVariables)
      ..addAll(inputFileVariables)
      ..addAll(promptVariables);
    final processedVariables = await runScripts(template.scripts, variables: variables);
    tell(grey(jsonEncode(processedVariables)));
    final tasks = buildOuputTasks(template.outputs, variables: processedVariables);
    writeOutputs(tasks);
  }

  String get templateFileName {
    return argResults![kOptionTemplate] + '.yaml';
  }

  String get templateFilePath {
    return config.templateDirectory + templateFileName;
  }
}

/// Wraps all helpers in simple functions to make [RunCommand.run] easier to read.
extension FunctionalRunCommand on RunCommand {
  TemplateDef readTemplate() => RunTemplateReader(this).readTemplate();

  Map<String, String> readInputs(TemplateDef template) =>
      InputReader(this).collectInputsFromArgs().askForInputvalues(template);

  Map<String, dynamic> readInputFiles() => InputFileReader(this).collectVariablesFromInputFiles();

  Map<String, String> readEnvironment() => EnvironmentReader(this).readEnvironment();

  Map<String, dynamic> readEnvironmentFile() => EnvironmentReader(this).readEnvironmentFiles();

  RunConfig readConfig() => RunConfigReader(this).readConfig();

  List<OutputTask> buildOuputTasks(List<OutputDef> outputs,
          {required Map<String, dynamic> variables}) =>
      OutputTaskBuilder(this) //
          .collectVariables(variables)
          .buildTasks(outputs);

  void writeOutputs(List<OutputTask> tasks) => OutputWriter(this).writeOutputs(tasks);

  Future<Map<String, dynamic>> runScripts(List<ScriptDef> scriptDefs,
          {required Map<String, dynamic> variables}) =>
      ScriptService(this).runScripts(scriptDefs, variables);
}
