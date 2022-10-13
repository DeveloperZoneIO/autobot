import 'dart:io';

import '../shared/file_and_dir_paths/config_folder_structure.dart';

class FileContents {
  static const initialConfigContent = '';

  static String? getContentFor(File file) {
    // config file
    if (file.path.endsWith(ConfigFolderConstants.fileNames.config)) {
      return initialConfigContent;
    }

    return null;
  }
}
