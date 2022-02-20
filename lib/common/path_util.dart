import 'package:dcli/dcli.dart';

extension PathUtil on String {
  String getDir() {
    final lastSlashIndex = lastIndexOf("/");
    if (lastSlashIndex == length) return this;
    return replaceRange(lastSlashIndex + 1, null, '');
  }

  /// Creates all missing directories from path.
  void createDirectory() {
    final directory = getDir();
    if (directory.isNotEmpty && !exists(directory)) {
      createDir(directory, recursive: true);
    }
  }
}
