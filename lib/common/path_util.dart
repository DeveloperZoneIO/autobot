import 'package:dcli/dcli.dart';

import 'package:autobot/common/dcli_utils.dart';

extension StringPathExtension on String {
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

class PathBuilder {
  PathBuilder();

  factory PathBuilder.from(String path) => PathBuilder().._path = path;

  String _path = '';

  PathBuilder resolve() {
    final isRelativePath = !_path.startsWith('/');

    if (isRelativePath) {
      _path = '$currentWorkingDirectory/$_path';
    }

    return this;
  }

  PathBuilder removeTrailingSlash() {
    if (_path.endsWith("/")) {
      final chars = _path.split('');
      chars.removeLast();
      _path = chars.join('');
    }

    return this;
  }

  PathBuilder append(String appendix) {
    _path = '$_path/$appendix';

    return this;
  }

  String get() => _path;
}
