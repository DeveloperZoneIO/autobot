import 'dart:cli';
import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:autobot/services/autobot_config_finder.dart';
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
part 'run_command_arg_results.dart';
part 'shell_runner.dart';
part 'utils/render_mixin.dart';
part 'utils/string_to_bool.dart';

/// Defines the run command of autobot.
/// `autobot run -t <task_name>` runs the task machting to <task_name>.
/// `autobot run -t <task_name> -i var1=a,var2=b` runs the task machting to <task_name> and inserts the given variables to autobot variables.
class RunCommand extends Command {
  late final RunCommandArgs args;
  final AutobotConfigReader configReader;
  static final kName = 'run';

  @override
  String get description => 'Runs a yaml template file.';
  @override
  String get name => kName;

  RunCommand({required this.configReader}) {
    args = RunCommandArgs(argParser, () => argResults!);
    args.initOptions();
  }

  @override
  void run() async {
    final taskRunner = TaskRunner(taskDirectory: configReader.getConfig().taskDir);

    // collect environment variables
    taskRunner.renderData.addAll(Platform.environment);

    // collect task flags
    taskRunner.renderData.addAll(args.taskFlags);

    // collect variables from cli arguments
    final variablesFromArgs = args.inputVariables;
    final unpackedVariablesFromArgs = parsePairs(variablesFromArgs);
    taskRunner.renderData.addAll(unpackedVariablesFromArgs);

    // collect variables from files given by cli argument
    final dataFilePathsArg = args.dataFilePaths;
    final dataFromAllFiles = readDataFromFiles(dataFilePathsArg);
    taskRunner.renderData.addAll(dataFromAllFiles);

    // run the task
    final mainTask = Task.fromFile(getTaskPath());
    await taskRunner.run(mainTask);
  }

  String getTaskPath() => configReader.getConfig().taskDir + args.taskName;
}
