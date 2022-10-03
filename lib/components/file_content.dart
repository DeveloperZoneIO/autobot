import 'dart:io';

import 'package:autobot/components/files.dart';

class FileContents {
  static const initialConfigContent = '';

  static String? getContentFor(File file) {
    if (file.path.endsWith(FileNames.configFileName)) return initialConfigContent;
    return null;
  }
}
