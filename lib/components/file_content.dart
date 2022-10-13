import 'dart:io';

import '../shared/file_and_dir_paths/file_and_dir_paths.dart';

class FileContents {
  static const initialConfigContent = '';

  static String? getContentFor(File file) {
    // config file
    if (file.path.endsWith(AutobotFilesNames.config)) {
      return initialConfigContent;
    }

    return null;
  }
}
