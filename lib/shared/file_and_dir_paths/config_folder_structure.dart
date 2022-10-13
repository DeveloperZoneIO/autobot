import 'dart:io';

import 'package:autobot/components/autobot_config.dart';

part 'config_folder_constants.dart';

class ConfigFolderStructure {
  ConfigFolderStructure._(this.locatedAt);
  factory ConfigFolderStructure.at(String path) => ConfigFolderStructure._(path);

  final String locatedAt;

  bool get exists => rootDirectory.existsSync();

  Directory get rootDirectory => Directory('$locatedAt/${ConfigFolderConstants.folderNames.main}');
  Directory get taskDirectory =>
      '/${ConfigFolderConstants.folderNames.tasks}'.createDirectoryBasedOn(rootDirectory);
  File get configFile =>
      '/${ConfigFolderConstants.fileNames.config}'.createFileBasedOn(rootDirectory);

  AutobotConfig? get configContent => AutobotConfig.fromFile(configFile);
}

extension SystemEntryExtension on String {
  File createFileBasedOn(Directory directory) => File(directory.path + this);
  Directory createDirectoryBasedOn(Directory directory) => Directory(directory.path + this);
}
