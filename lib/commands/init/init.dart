import 'package:args/command_runner.dart';
import 'package:autobot/components/file_creator.dart';
import 'package:dcli/dcli.dart';

import 'package:autobot/common/path_util.dart';
import '../../essentials/command_line_app/command_line_app.dart';
import '../../shared/base_paths/base_paths.dart';
import '../../shared/file_and_dir_paths/config_folder_structure.dart';

/// Defines the init command of autobot.
/// `autobot init` creates a autobot config yaml in the working directory.
/// `autobot init -g` creates a autobot config yaml in the home directory.
class InitCommand extends CLACommand {
  InitCommand({required this.paths, required this.appController})
      : super(
          name: 'init',
          description: 'Adds a config file to the current working directory.',
        ) {
    register(globalFlag);
    register(pathOption);
  }

  final BasePaths paths;
  final CLAController appController;
  final globalFlag = FlagArgument(name: 'global', shortName: 'g', defaultsTo: false);
  final pathOption = OptionsArgument(name: 'path', shortName: 'p', defaultsTo: null);

  @override
  void run() {
    if (has(globalFlag)) {
      _createAutobotFolderAndFilesAt(paths.globalDir);
    } else if (has(pathOption)) {
      final customPath = _reformatCustomPath(valueOf(pathOption));
      _createAutobotFolderAndFilesAt(customPath);
    } else {
      _createAutobotFolderAndFilesAt(paths.localDir);
    }
  }

  void _createAutobotFolderAndFilesAt(String baseDir) {
    final configFolderStructure = ConfigFolderStructure.at(baseDir);
    FileCreator().createResourceFilesSync(configFolderStructure);
  }

  String _reformatCustomPath(String filePath) => PathBuilder(paths) //
      .from(valueOf(pathOption))
      .resolve()
      .removeTrailingSlash()
      .append('')
      .get();

  void assertCustomPathIsValid(String path) {
    if (!isDirectory(path)) {
      appController.terminate(Print(
        red('ERROR -> ${pathOption.name} must ba a directory: '),
        orange(path),
      ));
    }
  }
}
