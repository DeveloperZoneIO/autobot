import 'package:dcli/dcli.dart';

import 'package:autobot/common/dcli_utils.dart';

class Files {
  static _FilePaths get localPaths => _FilePaths(pwd);
  static _FilePaths get globalPaths => _FilePaths(homeDirectory);
  static const defaultConfig = '''
config:
  taskDir: tasks/
  ''';
}

class FileNames {
  static const String resourceDirName = '.autobot';
  static const String taskDirName = 'tasks';
  static const String configFileName = 'config.yaml';
}

class _FilePaths {
  _FilePaths(this._basePath);

  final String _basePath;
  String get resourceDirectory => '$_basePath/${FileNames.resourceDirName}/';
  String get taskDirectory => '$resourceDirectory${FileNames.taskDirName}/';
  String get configFile => '$resourceDirectory${FileNames.configFileName}/';
}
