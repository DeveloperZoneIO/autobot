import 'dart:io';

import 'package:autobot/components/autobot_config.dart';

part 'file_and_dir_names.dart';

class ConfigFolderStructure {
  ConfigFolderStructure._(this.locatedAt);
  factory ConfigFolderStructure.at(String path) => ConfigFolderStructure._(path);

  final String locatedAt;

  bool get exists => rootDirectory.existsSync();

  Directory get rootDirectory => Directory('$locatedAt/${AutobotDirectoryNames.main}');
  Directory get taskDirectory =>
      '/${AutobotDirectoryNames.tasks}'.createDirectoryBasedOn(rootDirectory);
  File get configFile => '/${AutobotFilesNames.config}'.createFileBasedOn(rootDirectory);

  AutobotConfig? get configContent => AutobotConfig.fromFile(configFile);
}

extension SystemEntryExtension on String {
  File createFileBasedOn(Directory directory) => File(directory.path + this);
  Directory createDirectoryBasedOn(Directory directory) => Directory(directory.path + this);
}
