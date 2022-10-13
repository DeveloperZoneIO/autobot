import 'dart:io';

import 'package:autobot/common/null_utils.dart';
import 'package:autobot/components/file_content.dart';

import '../shared/file_and_dir_paths/config_folder_structure.dart';

class FileCreator {
  void createResourceFilesSync(ConfigFolderStructure systemEntities) {
    _createSystemEntries([
      systemEntities.rootDirectory,
      systemEntities.taskDirectory,
      systemEntities.configFile,
    ]);
  }

  void _createSystemEntries(List<FileSystemEntity> entities) {
    for (var entity in entities) {
      if (entity is Directory) _createDirIfNotExist(entity);
      if (entity is File) _createFileIfNotExist(entity);
    }
  }

  void _createDirIfNotExist(Directory dir) {
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }
  }

  void _createFileIfNotExist(File file) {
    if (file.existsSync()) return;

    file.createSync(recursive: true);
    FileContents.getContentFor(file)?.unpack((content) {
      file.writeAsStringSync(content);
    });
  }
}
