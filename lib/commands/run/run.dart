import 'dart:cli';
import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:autobot/commands/run/utils/config_folder.dart';
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
part 'shell_runner.dart';
part 'utils/render_mixin.dart';
part 'utils/string_to_bool.dart';

/// Defines the run command of autobot.
/// `autobot run -t <task_name>` runs the task machting to <task_name>.
/// `autobot run -t <task_name> -i var1=a,var2=b` runs the task machting to <task_name> and inserts the given variables to autobot variables.
class RunCommand extends CLACommand {
  static final kName = 'run';

  final CLAController appController;
  final BasePaths basePaths;
  final taskArgument = OptionsArg(name: 'task', shortName: 't', mandatory: true);
  final inputArgument = MultiOptionsArg(name: 'input', shortName: 'i');
  final filePathsArgument = MultiOptionsArg(name: 'input-file', shortName: 'f');

  RunCommand({required this.appController, required this.basePaths})
      : super(name: kName, description: 'Runs a yaml template file.') {
    register(taskArgument);
    register(inputArgument);
    register(filePathsArgument);
  }

  @override
  void run() async {
    final tasksFolderPath = ConfigFolder.findFirstAt(basePaths).taskDirectory.path;
    final targetTaskPath = tasksFolderPath + valueOf(taskArgument) + '.yaml';
    final task = Task.fromFile(targetTaskPath);

    TaskRunner(taskDirectory: _autobotConfig.taskDir)
      ..addRenderData(Platform.environment)
      ..addRenderData(flagsOf(taskArgument))
      ..addRenderData(valuesOf(inputArgument).toKeyValuePairs())
      ..addRenderData(readDataFromFiles(filePaths: valuesOf(filePathsArgument)))
      ..run(task);
  }

  AutobotConfig get _autobotConfig {
    final config = ConfigFolder.findFirstAt(basePaths).configContent;

    if (config == null) {
      appController.terminate(Print('Config file could not be parsed'));
    }

    return config;
  }
}
