import 'dart:cli';
import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:autobot/autobot.dart';
import 'package:autobot/commands/run/models/template.dart';
import 'package:autobot/commands/run/models/template.mapper.g.dart';
import 'package:autobot/common/collection_util.dart';
import 'package:autobot/common/dcli_utils.dart';
import 'package:autobot/common/path_util.dart';
import 'package:autobot/common/types.dart';
import 'package:autobot/common/yaml_utils.dart';
import 'package:autobot/components/components.dart';
import 'package:autobot/components/parse_pair.dart';
import 'package:autobot/components/read_yaml_as.dart';
import 'package:autobot/components/yaml_to_map.dart';
import 'package:autobot/config_reader.dart';
import 'package:autobot/tell.dart';
import 'package:cli_script/cli_script.dart' hide read;
import 'package:dcli/dcli.dart' hide run;
import 'package:mustache_template/mustache.dart';
import 'package:yaml/yaml.dart';

part 'base_scrip_runner.dart';
part 'environment_reader.dart';
part 'input_file_reader.dart';
part 'input_reader.dart';
part 'js_runner.dart';
part 'models/config.dart';
part 'models/input.dart';
part 'models/output_task.dart';
part 'output_task_builder.dart';
part 'output_writer.dart';
part 'run_config_reader.dart';
part 'script_service.dart';
part 'shell_runner.dart';
part 'template_reader.dart';
part 'utils/render_mixin.dart';
part 'utils/string_to_bool.dart';

/// Defines the run command of autobot.
/// `autobot run -t <task_name>` runs the task machting to <task_name>.
/// `autobot run -t <task_name> -i var1=a,var2=b` runs the task machting to <task_name> and inserts the given variables to autobot variables.
class RunCommand extends Command with TextRenderable {
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

  String get templateFileName => argResults![kOptionTemplate] + '.yaml';
  String get templateFilePath => config.templateDirectory + templateFileName;

  /// List of key-value string pairs from `--input`.
  List<String> get inputArgument => argResults![kOptionInput] ?? const [];

  /// List of input file paths form `--input-file`
  List<String> get inputFileArgument => argResults![kOptionInputFile] ?? const [];

  /// List of environment file paths
  List<String> get environmentFilePaths => config.environmentFilePaths;

  /// Adds all options to run command.
  void _addOptions() {
    argParser.addOption(kOptionTemplate, abbr: kOptionTemplateAbbr, mandatory: true);
    argParser.addMultiOption(kOptionInput, abbr: kOptionInputAbbr);
    argParser.addMultiOption(kOptionInputFile, abbr: kOptionInputFileAbbr);
  }

  @override
  void run() async {
    // TODO: Replace with: readYamlAs<RunConfig>();
    // TODO: Remove RunConfig and use Config only
    config = readConfig();
    final task = readYamlAs<TaskNode>(templateFilePath);

    renderVariables.clear();
    renderVariables.addAll(Platform.environment);
    renderVariables.addAll(parsePairs(inputArgument));
    renderVariables.addAll(readInputFiles(inputFileArgument));

    // for (final step in task.steps) {
    //   if (step is AskStep) readInput(step.key, step.prompt);
    //   if (step is VarsStep) renderVariables.addAll(step.vars);
    //   if (step is WriteStep) writeOutput(step as WriteStep);
    //   if (step is RunJavascriptStep) runJs(step.run_javascript);
    //   if (step is ShellStep) runShell(step.run_command);
    // }

    // final processedVariables = runScripts(template.scripts, variables: allVariables);
    // final tasks = buildOuputTasks(template.outputs, variables: processedVariables);
    // writeOutputs(tasks);
  }

  void runJs(String javascript) {
    final vars = JsRunner(this).run(javascript, renderVariables);
    renderVariables.clear();
    renderVariables.addAll(vars);
  }

  void runShell(String shellScript) {
    final vars = ShellRunner(this).run(shellScript, renderVariables);
    renderVariables.clear();
    renderVariables.addAll(vars);
  }

  void readInput(String key, String prompt) {
    if (!renderVariables.containsKey(key)) {
      renderVariables[key] = ask(yellow(prompt));
    }
  }

  void writeOutput(WriteStep step) {
    final writeFile = render(step.enabled).meansTrue;
    if (!writeFile) return;

    final outputTask = OutputTask(
      fileContent: render(step.content),
      outputPath: render(step.path),
      writeMethod: WriteMethod.from(
        name: render(step.writeMethod),
        extendAt: render(step.extendAt),
      ),
    );

    writeOutputs([outputTask]);
  }

  Map<String, dynamic> readInputFiles(List<String> paths) {
    final yamls = paths.map(readYaml);
    final contentMaps = yamls.map(yamlToMap);
    return contentMaps.isEmpty ? {} : contentMaps.reduce(merge);
  }
}

/// Wraps all helpers in simple functions to make [RunCommand.run] easier to read.
extension FunctionalRunCommand on RunCommand {
  // TaskWrapper readTemplate() => RunTemplateReader(this).readTemplate();

  // Map<String, String> readInputs(TaskWrapper template) =>
  //     InputReader(this).collectInputsFromArgs().askForInputvalues(template);

  Map<String, String> readEnvironment() => EnvironmentReader(this).readEnvironment();

  Map<String, dynamic> readEnvironmentFile() => EnvironmentReader(this).readEnvironmentFiles();

  RunConfig readConfig() => RunConfigReader(this).readConfig();

  // List<OutputTask> buildOuputTasks(List<OutputDef> outputs,
  //         {required Map<String, dynamic> variables}) =>
  //     OutputTaskBuilder(this) //
  //         .collectVariables(variables)
  //         .buildTasks(outputs);

  void writeOutputs(List<OutputTask> tasks) => OutputWriter(this).writeOutputs(tasks);

  // Map<String, dynamic> runScripts(List<ScriptDef> scriptDefs,
  //         {required Map<String, dynamic> variables}) =>
  //     ScriptService(this).runScripts(scriptDefs, variables);
}
