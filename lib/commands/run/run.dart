import 'dart:cli';
import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:autobot/shared/base_paths/base_paths.dart';
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

import '../../components/depenencies.dart';
import '../../essentials/command_line_app/command_line_app.dart';
import '../../shared/file_and_dir_paths/config_folder_structure.dart';
import '../../shared/when/when.dart';

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
  // final AutobotConfig? config;
  final CLAController appController;
  final BasePaths basePaths = provide();
  static final kName = 'run';

  @override
  String get description => 'Runs a yaml template file.';
  @override
  String get name => kName;

  RunCommand(this.appController) {
    args = RunCommandArgs(argParser, () => argResults!);
    args.initOptions();
  }

  @override
  void run() async {
    final taskRunner = TaskRunner(taskDirectory: _autobotConfig.taskDir);

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

  String getTaskPath() => _autobotConfig.taskDir + args.taskName;

  // Move to run command
  AutobotConfig get _autobotConfig {
    final l = _hasLocalAutobotDir;
    final g = _hasGlobalAutobotDir;
    final customPath = basePaths.customDir;

    final basePath = when(_hasLocalAutobotDir)
        .then(() => basePaths.localDir)
        .orWhen(_hasGlobalAutobotDir)
        .then(() => basePaths.globalDir)
        .orWhen(customPath != null && ConfigFolderStructure.at(customPath).exists)
        .then(() => basePaths.customDir!)
        .orNone();

    if (basePath.isNone()) {
      appController.terminate(Print('No ${ConfigFolderConstants.folderNames.main} found'));
    }

    final config = ConfigFolderStructure.at(basePath.get()).configContent;
    if (config == null) {
      appController.terminate(Print('Config file could not be parsed'));
    }

    return config;
  }

  bool get _hasLocalAutobotDir => ConfigFolderStructure.at(basePaths.localDir).exists;
  bool get _hasGlobalAutobotDir => ConfigFolderStructure.at(basePaths.globalDir).exists;
}
