import 'dart:cli';
import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:autobot/autobot.dart';
import 'package:autobot/commands/run/task_runner.dart';
import 'package:autobot/common/collection_util.dart';
import 'package:autobot/common/dcli_utils.dart';
import 'package:autobot/common/exceptions.dart';
import 'package:autobot/common/map_extension.dart';
import 'package:autobot/common/path_util.dart';
import 'package:autobot/common/yaml_utils.dart';
import 'package:autobot/components/components.dart';
import 'package:autobot/components/parse_pair.dart';
import 'package:autobot/components/read_data_file.dart';
import 'package:autobot/components/read_yaml.dart';
import 'package:autobot/components/task/task.dart';
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
class RunCommand extends Command with TextRenderable, StepHandlers {
  final kOptionTemplate = 'template';
  final kOptionTemplateAbbr = 't';
  final kOptionInput = 'input';
  final kOptionInputAbbr = 'i';
  final kOptionInputFile = 'input-file';
  final kOptionInputFileAbbr = 'f';

  late final RunConfig config;

  @override
  String get description => 'Runs a yaml template file.';
  @override
  String get name => 'run';
  String get templateFileName => argResults![kOptionTemplate] + '.yaml';
  String get templateFilePath => config.templateDirectory + templateFileName;

  RunCommand() {
    _addOptions();
  }

  /// Adds all options to run command.
  void _addOptions() {
    argParser.addOption(kOptionTemplate, abbr: kOptionTemplateAbbr, mandatory: true);
    argParser.addMultiOption(kOptionInput, abbr: kOptionInputAbbr);
    argParser.addMultiOption(kOptionInputFile, abbr: kOptionInputFileAbbr);
  }

  @override
  void run() async {
    // TODO: Remove RunConfig and use Config only
    config = RunConfigReader().readConfig();
    final runner = TaskRunner();

    renderData.clear();

    // collect environment variables
    renderData.addAll(Platform.environment);

    // collect variables from cli arguments
    final variablesFromArgs = argResults![kOptionInput] ?? const [];
    final unpackedVariablesFromArgs = parsePairs(variablesFromArgs);
    renderData.addAll(unpackedVariablesFromArgs);

    // collect variables from files given by cli argument
    final List<String> dataFilePathsArg = argResults![kOptionInputFile] ?? const [];
    final allDataFilePaths = dataFilePathsArg + config.environmentFilePaths;
    final dataFromAllFiles = readDataFromFiles(allDataFilePaths);
    renderData.addAll(dataFromAllFiles);

    final task = Task.fromFile(templateFilePath);

    for (final step in task.steps) {
      if (step is VariablesStep) handleVariablesStep(step);
      if (step is AskStep) handleAskStep(step.key, step.prompt);
      if (step is JavascriptStep) handleJavascriptStep(step.run);
      if (step is CommandStep) handleCommandStep(step.run);
      if (step is WriteStep) handleWriteStep(step);
      if (step is ReadStep) handleReadStep(step);
    }

    await runner.run();
  }
}

/// Wraps all step handlers for stucture reasons.
mixin StepHandlers on TextRenderable {
  void handleVariablesStep(VariablesStep step) {
    renderData.addAll(step.vars);
  }

  void handleJavascriptStep(String javascript) {
    final vars = JsRunner().run(javascript, renderData);
    renderData.clear();
    renderData.addAll(vars);
  }

  void handleCommandStep(String shellScript) {
    ShellRunner().run(shellScript, renderData);
  }

  void handleAskStep(String key, String prompt) {
    if (!renderData.containsKey(key)) {
      renderData[key] = ask(yellow(prompt));
    }
  }

  void handleWriteStep(WriteStep step) {
    final writeFile = render(step.enabled).meansTrue;
    if (!writeFile) return;

    final outputTask = OutputTask(
      fileContent: render(step.content),
      outputPath: render(step.file),
      writeMethod: WriteMethod.from(
        name: render(step.writeMethod),
        extendAt: render(step.extendAt),
      ),
    );

    OutputWriter().writeOutputs([outputTask]);
  }

  void handleReadStep(ReadStep step) {
    if (step.required) {
      renderData.addAll(readDataFromFiles([step.file]));
      return;
    }

    final result = tryReadDataFromFile([step.file]);
    if (result != null) {
      renderData.addAll(result);
    }
  }
}
