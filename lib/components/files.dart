import 'dart:io';

import 'package:dcli/dcli.dart';

import 'package:autobot/common/dcli_utils.dart';

class Files {
  static AutobotFilePaths get local => AutobotFilePaths(pwd);
  static AutobotFilePaths get global => AutobotFilePaths(homeDirectory);
}

class FileNames {
  static const String resourceDirName = '.autobot';
  static const String taskDirName = 'tasks';
  static const String configFileName = 'config.yaml';
}

class AutobotFilePaths {
  AutobotFilePaths(this._basePath);

  final String _basePath;
  Directory get resourceDirectory => Directory('$_basePath/${FileNames.resourceDirName}/');
  Directory get taskDirectory => Directory('${resourceDirectory.path}${FileNames.taskDirName}/');
  File get config => File('${resourceDirectory.path}${FileNames.configFileName}');

  List<Directory> get allDirs => [resourceDirectory, taskDirectory];
  List<File> get allFiles => [config];
}
