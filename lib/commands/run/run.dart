import 'dart:cli';
import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:cli_script/cli_script.dart' hide read;
import 'package:dcli/dcli.dart' hide run;
import 'package:mustache_template/mustache.dart';

import 'package:autobot/commands/run/task_runner.dart';
import 'package:autobot/common/exceptions.dart';
import 'package:autobot/common/map_extension.dart';
import 'package:autobot/common/path_util.dart';
import 'package:autobot/components/autobot_config.dart';
import 'package:autobot/components/components.dart';
import 'package:autobot/components/parse_pair.dart';
import 'package:autobot/components/read_data_file.dart';
import 'package:autobot/components/task/task.dart';
import 'package:autobot/tell.dart';

part 'js_runner.dart';
part 'models/output_task.dart';
part 'output_writer.dart';
part 'shell_runner.dart';
part 'utils/render_mixin.dart';
part 'utils/string_to_bool.dart';

/// Defines the run command of autobot.
/// `autobot run -t <task_name>` runs the task machting to <task_name>.
/// `autobot run -t <task_name> -i var1=a,var2=b` runs the task machting to <task_name> and inserts the given variables to autobot variables.
class RunCommand extends Command {
  final AutobotConfig? config;

  static final kOptionTask = 'task';
  static final kOptionTaskAbbr = 't';
  static final kOptionInput = 'input';
  static final kOptionInputAbbr = 'i';
  static final kOptionInputFile = 'input-file';
  static final kOptionInputFileAbbr = 'f';
  static final kName = 'run';

  @override
  String get description => 'Runs a yaml template file.';
  @override
  String get name => kName;

  RunCommand(this.config) {
    _addOptions();
  }

  /// Adds all options to run command.
  void _addOptions() {
    argParser.addOption(kOptionTask, abbr: kOptionTaskAbbr, mandatory: true);
    argParser.addMultiOption(kOptionInput, abbr: kOptionInputAbbr);
    argParser.addMultiOption(kOptionInputFile, abbr: kOptionInputFileAbbr);
  }

  @override
  void run() async {
    final taskRunner = TaskRunner(taskDirectory: requireConfig.taskDir);

    // collect environment variables
    taskRunner.renderData.addAll(Platform.environment);

    // collect variables from cli arguments
    final variablesFromArgs = argResults![kOptionInput] ?? const [];
    final unpackedVariablesFromArgs = parsePairs(variablesFromArgs);
    taskRunner.renderData.addAll(unpackedVariablesFromArgs);

    // collect variables from files given by cli argument
    final List<String> dataFilePathsArg = argResults![kOptionInputFile] ?? const [];
    final dataFromAllFiles = readDataFromFiles(dataFilePathsArg);
    taskRunner.renderData.addAll(dataFromAllFiles);

    // run the task
    final mainTask = Task.fromFile(getTaskPath());
    await taskRunner.run(mainTask);
  }

  String getTaskName() => argResults![kOptionTask] + '.yaml';
  String getTaskPath() => requireConfig.taskDir + getTaskName();

  AutobotConfig get requireConfig {
    if (config == null) {
      throw MissingConfigFile();
    } else {
      return config!;
    }
  }
}
