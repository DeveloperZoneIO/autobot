import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:autobot/common/dcli_utils.dart';
import 'package:autobot/components/file_creator.dart';
import 'package:dcli/dcli.dart';

import 'package:autobot/common/path_util.dart';
import 'package:autobot/components/files.dart';

import '../../essentials/command_line_app/command_line_app.dart';

/// Defines the init command of autobot.
/// `autobot init` creates a autobot config yaml in the working directory.
/// `autobot init -g` creates a autobot config yaml in the home directory.
class InitCommand extends Command with RegisteredArgs {
  InitCommand(this.appController) {
    register(globalFlag);
    register(pathOption);
  }

  final CLAController appController;
  final globalFlag = FlagArgument(name: 'global', shortName: 'g', defaultsTo: false);
  final pathOption = OptionsArgument(name: 'path', shortName: 'p', defaultsTo: null);

  @override
  String get description => 'Adds a config file to the current working directory.';

  @override
  String get name => 'init';

  @override
  void run() {
    if (has(globalFlag)) {
      _createAutobotFolderAndFilesAt(homeDirectory);
    } else if (has(pathOption)) {
      final customPath = _reformatCustomPath(valueOf(pathOption));
      _createAutobotFolderAndFilesAt(customPath);
    } else {
      _createAutobotFolderAndFilesAt(currentWorkingDirectory);
    }
  }

  void _createAutobotFolderAndFilesAt(String baseDir) {
    final filePaths = AutobotFilePaths(baseDir);
    FileCreator().createResourceFilesSync(filePaths);
  }

  String _reformatCustomPath(String filePath) => PathBuilder.from(valueOf(pathOption)) //
      .resolve()
      .removeTrailingSlash()
      .append('')
      .get();

  void assertCustomPathIsValid(String path) {
    if (!isDirectory(path)) {
      appController.executel(ExitApp(
        red('ERROR -> ${pathOption.name} must ba a directory: '),
        orange(path),
      ));
    }
  }
}
