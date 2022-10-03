import 'package:autobot/common/null_utils.dart';
import 'package:autobot/components/file_content.dart';
import 'package:autobot/components/files.dart';
import 'package:dcli/dcli.dart';

class FileCreator {
  void createResourceFilesSync(AutobotFilePaths filePaths) {
    _createDirsIfNotExist(filePaths);
    _createFilesIfNotExist(filePaths);
  }

  void _createDirsIfNotExist(AutobotFilePaths filePaths) {
    for (final dir in filePaths.allDirs) {
      if (!dir.existsSync()) {
        dir.createSync(recursive: true);
      }
    }
  }

  void _createFilesIfNotExist(AutobotFilePaths filePaths) {
    for (final file in filePaths.allFiles) {
      if (file.existsSync()) continue;

      file.createSync(recursive: true);
      FileContents.getContentFor(file)?.unpack((content) {
        file.writeAsStringSync(content);
      });
    }
  }
}
