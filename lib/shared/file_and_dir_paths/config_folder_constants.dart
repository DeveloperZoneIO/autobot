part of 'config_folder_structure.dart';

class ConfigFolderConstants {
  static const fileNames = AutobotFilesNames._();
  static const folderNames = AutobotFolderNames._();
}

class AutobotFilesNames {
  const AutobotFilesNames._();
  final String config = 'config.yaml';
}

class AutobotFolderNames {
  const AutobotFolderNames._();
  final String main = '.autobot';
  final String tasks = 'tasks';
}
