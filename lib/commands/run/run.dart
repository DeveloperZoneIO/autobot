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
class RunCommand extends Command {
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
  String get taskFilePath => config.templateDirectory + templateFileName;

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
    final runner = TaskRunner(taskDirectory: config.templateDirectory);

    // collect environment variables
    runner.renderData.addAll(Platform.environment);

    // collect variables from cli arguments
    final variablesFromArgs = argResults![kOptionInput] ?? const [];
    final unpackedVariablesFromArgs = parsePairs(variablesFromArgs);
    runner.renderData.addAll(unpackedVariablesFromArgs);

    // collect variables from files given by cli argument
    final List<String> dataFilePathsArg = argResults![kOptionInputFile] ?? const [];
    final allDataFilePaths = dataFilePathsArg + config.environmentFilePaths;
    final dataFromAllFiles = readDataFromFiles(allDataFilePaths);
    runner.renderData.addAll(dataFromAllFiles);

    // run the task
    final mainTask = Task.fromFile(taskFilePath);
    await runner.run(mainTask);
  }
}
