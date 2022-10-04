import 'dart:io';
import 'package:dcli/dcli.dart';
import 'package:autobot/common/dcli_utils.dart';

class Files {
  static AutobotFilePathsDef get local => AutobotFilePaths(pwd);
  static AutobotFilePathsDef get global => AutobotFilePaths(homeDirectory);
}

class FileNames {
  static const String resourceDirName = '.autobot';
  static const String taskDirName = 'tasks';
  static const String configFileName = 'config.yaml';
}

abstract class AutobotFilePathsDef {
  AutobotFilePathsDef(this.basePath);
  final String basePath;

  Directory get resourceDirectory;
  Directory get taskDirectory;
  File get config;

  List<Directory> get allDirs => [resourceDirectory, taskDirectory];
  List<File> get allFiles => [config];
}

class AutobotFilePaths extends AutobotFilePathsDef {
  AutobotFilePaths(super.basePath);

  @override
  Directory get resourceDirectory => Directory('$basePath/${FileNames.resourceDirName}/');

  @override
  Directory get taskDirectory => Directory('${resourceDirectory.path}${FileNames.taskDirName}/');

  @override
  File get config => File('${resourceDirectory.path}${FileNames.configFileName}');
}
